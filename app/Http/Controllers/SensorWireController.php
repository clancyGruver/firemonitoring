<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\WireSensor;
use App\WireSensorPrevState;

class SensorWireController extends Controller
{
    public function addJson(Request $request){
        $data = $request->all();
        $params = [];
        if(isset($data['payload']['sensorData']['SP5_valid']))       
        	$SP5 = $data['payload']['sensorData']['SP5_valid'];
       	else $SP5 = false;
        if(isset($data['payload']['sensorData']['is_good']))       
        	$is_good = $data['payload']['sensorData']['is_good'];
       	else $is_good = false;
        $params['wire_id'] = $data['payload']['sensorData']['wire_id'];
        $params['sensor_id'] = $data['payload']['sensor']['id'];
        $params['name'] = $data['payload']['sensorData']['name'];
        $params['floor'] = $data['payload']['sensorData']['floor'];
        $params['cabinet_name'] = $data['payload']['sensorData']['cabinet_name'];
        $params['comment'] = $data['payload']['sensorData']['comment'];
        $params['SP5_valid'] = $SP5;
        $params['is_good'] = $is_good;
        $params['created_user_id'] = $data['user_id'];

        $obj = new WireSensor($params);
        $obj->save();

        return response()->json($obj);
    }

    public function updateJson(Request $request){
        $data = $request->all();
        $params = [];
        if(isset($data['payload']['sensorData']['SP5_valid']))       
        	$SP5 = $data['payload']['sensorData']['SP5_valid'];
       	else $SP5 = false;
        if(isset($data['payload']['sensorData']['is_good']))       
        	$is_good = $data['payload']['sensorData']['is_good'];
       	else $is_good = false;
        $params['wire_id'] = $data['payload']['sensorData']['wire_id'];
        $params['sensor_id'] = $data['payload']['sensor']['id'];
        $params['name'] = $data['payload']['sensorData']['name'];
        $params['floor'] = $data['payload']['sensorData']['floor'];
        $params['cabinet_name'] = $data['payload']['sensorData']['cabinet_name'];
        $params['comment'] = $data['payload']['sensorData']['comment'];
        $params['SP5_valid'] = $SP5;
        $params['is_good'] = $is_good;
        $params['created_user_id'] = $data['user_id'];

    	$id = $data['payload']['sensorData']['id'];

        $obj = WireSensor::find($id);
    	$prev_state = new WireSensorPrevState($obj->toArray());
    	$prev_state->wire_sensor_id = $obj->id;
    	unset($prev_state->id);
    	$prev_state->save();

        $obj->update($params);
        return response()->json($obj);
    }
}
