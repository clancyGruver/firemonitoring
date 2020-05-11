<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\WireSensor;
use App\WireSensorPrevState;
use App\repairQueue;
use App\device_limitations;
use App\WorkType;

class SensorWireController extends Controller
{
    public function addJson(Request $request){
        $data = $request->all();
        $count = 1;
        if(isset($data['sensorData']['count']) && $data['sensorData']['count'])
            $count = $data['sensorData']['count'];
        $params = [];
        if(isset($data['sensorData']['SP5_valid']))
        	$SP5 = $data['sensorData']['SP5_valid'];
       	else $SP5 = false;
        if(isset($data['sensorData']['is_good']))
        	$is_good = $data['sensorData']['is_good'];
       	else $is_good = false;
        if($count < 2){
            $params['name'] = $data['sensorData']['name'];
            $params['cabinet_name'] = $data['sensorData']['cabinet_name'];
        }
        $params['wire_id'] = $data['sensorData']['wire_id'];
        $params['sensor_id'] = $data['sensor']['id'];
        $params['floor'] = $data['sensorData']['floor'];
        $params['comment'] = $data['sensorData']['comment'];
        $params['SP5_valid'] = $SP5;
        $params['is_good'] = $is_good;
        $params['created_user_id'] = $request->header('x-user');

        $objs = [];
        for($i = 0; $i < $count; $i++){
            if($count > 1){
                $params['name'] = $i + 1;
            }
            $obj = new WireSensor($params);
            $obj->save();

            $id = $obj->id;
            $work = new WorkType([
                'object_id' => $data['ObjectId'],
                'object_device_id' => $params['sensor_id'],
                'user_id' => $params['created_user_id'],
                'tbl_name' => 'App\Sensor',
                'work_type' => 'setup'
            ]);
            $work->save();
            $objs[] = $obj;
        }

        return response()->json($objs);
    }

    public function deleteJson($id, Request $request){
        $obj = WireSensor::find($id);
        $prev_state = new WireSensorPrevState($obj->toArray());
        $prev_state->wire_sensor_id = $obj->id;
        unset($prev_state->id);
        $prev_state->save();

        $obj->delete();
    }

    public function storeCoordsJson($id, Request $request){
        $obj = WireSensor::find($id);
        $data = $request->only(['lat', 'lng', 'bti_files_id']);
        $data['created_user_id'] = $request->header('x-user');
        $obj->update($data);
        return response()->json($obj);
    }

    public function updateJson(Request $request){
        $data = $request->all();
        $params = [];
        if(isset($data['sensorData']['SP5_valid']))
        	$SP5 = $data['sensorData']['SP5_valid'];
       	else $SP5 = false;
        if(isset($data['sensorData']['is_good']))
        	$is_good = $data['sensorData']['is_good'];
       	else $is_good = false;
        $params['wire_id'] = $data['sensorData']['wire_id'];
        $params['sensor_id'] = $data['sensor']['id'];
        $params['name'] = $data['sensorData']['name'];
        $params['floor'] = $data['sensorData']['floor'];
        if(isset($data['sensorData']['cabinet_name']) && $data['sensorData']['cabinet_name']){
            $params['cabinet_name'] = $data['sensorData']['cabinet_name'];
        }
        $params['comment'] = $data['sensorData']['comment'];
        $params['SP5_valid'] = $SP5;
        $params['is_good'] = $is_good;
        $params['created_user_id'] = $request->header('x-user');

    	$id = $data['sensorData']['id'];
        $sensor_id = $data['sensorData']['sensor_id'];

        $obj = WireSensor::find($id);
    	$prev_state = new WireSensorPrevState($obj->toArray());
    	$prev_state->wire_sensor_id = $obj->id;
    	unset($prev_state->id);
    	$prev_state->save();

        if($obj->is_good == 0 && $params['is_good'] == 1){
            $repairQueueObj = repairQueue::where([
                ['device_id','=',$id],
                ['type','=','sensor'],
            ])->first();
            if($repairQueueObj){
                $repairQueueObj->update([
                    'repairer_id' => $request->header('x-user'),
                    'done_at' => date('Y-m-d H:i:s'),
                ]);
            }
        }
        if($obj->is_good == 1 && $params['is_good'] == 0){
            $limitation_id = device_limitations::where([
                ['tbl_name','=','App\Sensor'],
                ['device_id','=',$sensor_id],
            ])->first();
            $repairData = [
                'object_id' => $data['ObjectId'],
                'device_id' => $id,
                'type' => 'sensor',
                'finder_id' => $request->header('x-user'),
                'limitation_id' => $limitation_id->id,
            ];
            $repairQueueObj = new repairQueue($repairData);
            $repairQueueObj->save();
        }

        $obj->update($params);
        return response()->json($obj);
    }
}
