<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\calendar;

class calendarController extends Controller
{
    public function addObject(Request $request){
	    $validatedData = $request->validate([
	        'technic_id' => 'required|integer',
			'object_id' => 'required|integer',
			'work_type' => 'required',
			'planned_at' => 'required',
			'comment',
	    ]);
	    $data_for_check = [
			'technic_id' => $validatedData['technic_id'],
			'object_id' => $validatedData['object_id'],
			'planned_at' => $validatedData['planned_at'],
	    ];
	    $additioal_data = [
			'comment' => empty($validatedData['comment']) ? '' : $validatedData['comment'],
			'admin_id' => $request->header('x-user'),
	    ];
	    $res = [];
	    foreach ($validatedData['work_type'] as $value) {
	    	$obj = calendar::where($data_for_check)->first();
	    	if($obj)
	    		continue;
	    	$data = array_merge($data_for_check, $additioal_data,  ['work_type'=>$value]);
	    	$obj = new calendar($data);
	    	$obj->save();
	    	$res[] = $obj;
	    }
	    return response()->json($res);
    }
}
