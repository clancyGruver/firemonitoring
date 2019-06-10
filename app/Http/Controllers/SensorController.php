<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Sensor;

class SensorController extends Controller
{
    public function index(){
    	$items = Sensor::where('is_active',1)->get();
    	return view('admin.sensors.index',['sensors' => $items]);
    }

    public function getAllJson(){
    	$items = Sensor::where('is_active',1)->get()->toArray();
    	$key_names = ['is_automate','is_address','standalon_smoke_is_radioisotop'];
    	foreach ($items as $key => $value) {
    		foreach ($value as $k => $v) {
	    		if(in_array($k , $key_names))
	    			$items[$key][$k] = ($v) ? 'true' : 'false';
    		}
    	}
    	return response()->json($items);
    }

    public function storeJson(Request $request){
        $data = $request->all();
        $params = [];
        foreach ($data['sensor_data'] as $key => $value) {
        	if($value == 'true')
        		$value = true;
        	if($value == 'false')
        		$value = false;
        	$params[$key] = $value;
        }
        
        $params['created_user_id'] = $data['user_id'];

        $obj = new Sensor($params);
        $obj->save();

        return response()->json($obj);
    }
    public function deleteJson(Request $request){
        $data = $request->all();
		
		$obj = Sensor::find($data['sensor_id']);
        $obj->is_active = 0;
        $obj->created_user_id = $data['user_id'];
        $obj->save();

        return response()->json($obj);
	}
}
