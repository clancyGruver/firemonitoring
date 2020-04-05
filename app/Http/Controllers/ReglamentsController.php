<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\device_reglament_element as DRE;
use App\device_reglament as DR;
use App\reglament_works as RW;
use App\Object_Device as OD;

class ReglamentsController extends Controller
{
    public function deleteElement($id, Request $request){
    	$obj = DRE::find($id);
    	$obj->delete();
    	return response()->json($obj);
    }
    public function updateElement($id, Request $request){
    	$obj = DRE::find($id);
    	$data = $request->all();
        $data['created_user_id'] = $request->header('x-user');
    	$obj->update($data);
    	return response()->json($obj);
    }
    public function addElement(Request $request){
    	$data = $request->all();
        $data['created_user_id'] = $request->header('x-user');
    	$obj = new DRE($data);
    	$obj->save();
    	return response()->json($obj);
    }

    public function updateReglament($id, Request $request){
    	$obj = DR::find($id);
    	$data = $request->all();
        $data['created_user_id'] = $request->header('x-user');
    	$obj->update($data);
    	return response()->json($obj);
    }
	public function deleteReglament($id, Request $request){
    	$obj = DR::find($id);
    	$obj->delete();
    	return response(200);
	}
	public function addReglament(Request $request){
		$data = $request->all();
		$data['created_user_id'] = $request->header('x-user');
		$obj = new DR($data);
		$obj->save();
		return response()->json($obj);
	}

	public function unworked(Request $request){
		$nextWeek = new \DateTime();
		$nextWeek->add(new \DateInterval('P1W'));
		$items = RW::whereNull('done_at')->orWhere('planned_reglament_at','<=', $nextWeek->format('Y-m-d H:i:s'))->with('object')->get();
    	return response()->json($items);
	}

	public function getReglaments($id, Request $request){
		$OD = OD::find($id)->devicable()->first();
		$items = DR::where('device_id',$OD->id)->with(['elements'])->get();
		foreach ($items as $item) {
			$item->reglament_work = $item->work($id)->first();
		}
		return response()->json([
			'device' => $OD,
			'reglaments' => $items,
		]);
	}

	public function updateWork($id, Request $request){
		$obj = RW::find($id);
		if($request->input('reglamentDate')){
			$cur_date = new \DateTime($request->input('reglamentDate'));
		} else {
			$cur_date = new \DateTime();
		}
		$obj->update(['done_at' => $cur_date->format('Y-m-d H:i:s')]);
		return response()->json($obj);
	}
}
