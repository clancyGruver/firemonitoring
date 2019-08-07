<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\DeviceClass;
use App\device_limitations as limits;

class DeviceLimitationsController extends Controller
{
    public function index(){
        return view('admin.objects.index');
    }

    public function indexJson(){
        $items = DeviceClass::where('is_active',1)->with('devices')->get();
        return response()->json($items);
    }

    public function update($id, Request $request){
        $obj = limits::find($id);
        $data = $request->only('text');
        $data['created_user_id'] = $request->header('x-user');
        $obj->update($data);
        return response()->json($obj);
    }

    public function insert(Request $request){
        $data = $request->only('text','device_id','model_name');
        if(trim($data['text']) == '')
        	return response(500);
        $data['created_user_id'] = $request->header('x-user');
        $obj = new limits($data);
        $obj->save();
        return response()->json($obj);
    }

    public function delete($id, Request $request){
        $obj = limits::destroy($id);
        return response(200);
    }
}
