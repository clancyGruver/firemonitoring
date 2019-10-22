<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\device_antenna as DA;
use Illuminate\Support\Facades\Auth;
use App\device_antenna_params as DAP;

class DeviceAntennaController extends Controller
{
    public function index(){
        $items = DA::all();
        return view('admin.antennas.index',['items' => $items]);
    }

    public function storeParams(Request $request){
        $params = $request->all();
        $params['created_user_id'] = $request->header('x-user');
        if(isset($params['id'])){
            $item = DAP::find($params['id']);
            $item->update($params);
        }
        else{
            $item = new DAP($params);
            $item->save();
        }
        return response()->json($item);
    }

    public function getJson(){
        $items = DA::all();
        return response()->json($items);
    }

    public function detail($id, Request $request){
        $item = DA::find($id);
        return view('admin.antennas',['item' => $item]);
    }

    public function edit($id, Request $request){
        $item = DA::find($id);
        return view('admin.antennas.edit',['item' => $item]);
    }

    public function delete($id, Request $request){
        $item = DA::destroy($id);
    }

    public function add(Request $request){
        return view('admin.antennas.add');
    }

    public function update($id, Request $request){
        $request->validate([
            'name' => 'required',
        ]);
        $obj = DA::find($id);
        $params = $request->except(['id','_token']);
        $params['created_user_id'] = Auth::user()->id;
        $obj->update($params);
        return redirect('admin/antennas');
    }

    public function store( Request $request){
        $validatedData = $request->validate([
            'name' => 'required',
        ]);
        $obj = new DA($request->except('_token'));
        $obj->created_user_id = Auth::user()->id;
        $obj->save();
        return redirect('admin/antennas');
    }
}
