<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\device_alert as DA;
use Illuminate\Support\Facades\Auth;
use Illuminate\Validation\Rule;

class DeviceAlertController extends Controller
{
    public function index(){
        $items = DA::all();
        return view('admin.alert.index',['items' => $items]);
    }

    public function getJson(){
        $items = DA::all();
        return response()->json($items);
    }

    public function detail($id, Request $request){
        $item = DA::find($id);
        return view('admin.alert',['item' => $item]);
    }

    public function edit($id, Request $request){
        $item = DA::find($id);
        return view('admin.alert.edit',['item' => $item]);
    }

    public function delete($id, Request $request){
        DA::destroy($id);
    }

    public function add(Request $request){
        return view('admin.alert.add');
    }

    public function update($id, Request $request){
        $request->validate([
            'name' => 'required',
            'type' => ['required', Rule::in(['sound','voice','light'])],
			'power' => 'numeric'
        ]);
        $obj = DA::find($id);
        $params = $request->except(['id','_token']);
        if($request->instruction){
            $params['instruction'] = $request->instruction->getClientOriginalName();
            $request->instruction->storeAs('instructions/alert/'.$obj->id, $request->instruction->getClientOriginalName());
        }
        $params['created_user_id'] = Auth::user()->id;
        $obj->update($params);
        return redirect('admin/alert');
    }

    public function store( Request $request){
        $request->validate([
            'name' => 'required',
            'type' => ['required', Rule::in(['sound','voice','light'])],
			'power' => 'numeric'
        ]);
        $obj = new DA($request->except('_token'));
        $obj->created_user_id = Auth::user()->id;
        $obj->save();
        if($request->instruction){
            $obj->instruction = $request->instruction->getClientOriginalName();
            $request->instruction->storeAs('instructions/alert/'.$obj->id, $request->instruction->getClientOriginalName());
        }
        $obj->save();
        return redirect('admin/alert');
    }
}
