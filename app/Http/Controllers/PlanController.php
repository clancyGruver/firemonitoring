<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\reglament_works;

class PlanController extends Controller
{
    public function sensorsReglament(Request $request){
    	$sensors = reglament_works::where('tbl_name', 'App/Sensor')->with(['sensor','reglament'])->get()->toArray();
    	$objects = [];
    	foreach ($sensors as $sensor) {
    		if(isset($sensor['sensor']['wire'])){
    			//check object id
    			$object_id = $sensor['sensor']['wire']['device']['object']['id'];
	    		if(!array_key_exists($object_id, $objects))
	    			$objects[$object_id] = [];
	    		//check device in object
	    		$device_id = $sensor['sensor']['wire']['device']['id'];
	    		if(!array_key_exists($device_id,$objects[$object_id]))
	    			$objects[$object_id][$device_id] = [];
	    		//check wire in device
	    		$wire_id = $sensor['sensor']['wire']['id'];
	    		if(!array_key_exists($wire_id,$objects[$object_id][$device_id]))
	    			$objects[$object_id][$device_id][$wire_id] = [
	    				'name' => $sensor['sensor']['wire']['description'],
	    				'sensors' => [],
	    			];
	    		$objects[$object_id][$device_id][$wire_id][] = [
	    			'id' => $sensor['sensor']['id'],
	    			'name' => $sensor['sensor']['name'],
	    			'planned_reglament_at' => $sensor['planned_reglament_at'],
	    			'reglament' => $sensor['reglament'],
	    		];
	    		//$objects[$object_id][$device_id][$wire_id]['sensors'][] = $sensor;
    		}
    	}
    	return response()->json($objects);
    }

    public function index(Request $request){
    	$reglament_works = reglament_works::all();
    	$events = [];
    	foreach ($reglament_works as $reglament) {
    		$events[] = \Calendar::event(
			    $reglament->reglament->name, //event title
			    false, //full day event?
			    new \DateTime($reglament->planned_reglament_at), //start time (you can also use Carbon instead of DateTime)
			    new \DateTime($reglament->planned_reglament_at) //end time (you can also use Carbon instead of DateTime)
			);
    	}
    	//$calendar_details = \Calendar::addEvents($events);
    	return response()->json($events);
    }
}
