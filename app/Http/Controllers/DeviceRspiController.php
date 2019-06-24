<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\device_rspi as DR;
use Illuminate\Support\Facades\Auth;

class DeviceRspiController extends Controller
{
    public function index(){
        $items = DR::all();
        return view('admin.rspi.index',['items' => $items]);
    }

    public function getJson(){
        $items = DR::all();
        return response()->json($items);
    }

    public function detail($id, Request $request){
        $item = DR::find($id);
        return view('admin.rspi',['item' => $item]);
    }

    public function edit($id, Request $request){
        $item = DR::find($id);
        return view('admin.rspi.edit',['item' => $item]);
    }

    public function delete($id, Request $request){
        DR::destroy($id);
    }

    public function add(Request $request){
        return view('admin.rspi.add');
    }

    public function update($id, Request $request){
        $request->validate([
            'name' => 'required',
        ]);
        $obj = DR::find($id);
        $params = $request->except(['id','_token']);
        if($request->instruction){
            $params['instruction'] = $request->instruction->getClientOriginalName();
            $request->instruction->storeAs('instructions/rspi/'.$obj->id, $request->instruction->getClientOriginalName());
        }
        $params['created_user_id'] = Auth::user()->id;
        $obj->update($params);
        return redirect('admin/rspi');
    }

    public function store( Request $request){
        $validatedData = $request->validate([
            'name' => 'required',
        ]);
        $obj = new DR($request->except('_token'));
        $obj->created_user_id = Auth::user()->id;
        $obj->save();
        if($request->instruction){
            $obj->instruction = $request->instruction->getClientOriginalName();
            $request->instruction->storeAs('instructions/rspi/'.$obj->id, $request->instruction->getClientOriginalName());
        }
        $obj->save();
        return redirect('admin/rspi');
    }
}
