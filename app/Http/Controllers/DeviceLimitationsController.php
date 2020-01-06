<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\DeviceClass;
use App\device_limitations as limits;
use App\Object_Device as OD;
use App\object_device_reglament_limitations as ODRL;
use Illuminate\Support\Facades\Log;

class DeviceLimitationsController extends Controller
{
	public function index()
	{
		return view('admin.objects.index');
	}

	public function indexJson()
	{
		$items = DeviceClass::where('is_active', 1)->with('devices')->get();
		return response()->json($items);
	}

	public function update($id, Request $request)
	{
		$obj = limits::find($id);
		$data = $request->only(['text', 'isCritical']);
		$data['created_user_id'] = $request->header('x-user');
		$obj->update($data);
		return response()->json($obj);
	}

	public function insert(Request $request)
	{
		$data = $request->only('text', 'device_id', 'tbl_name');
		if (trim($data['text']) == '')
			return response(500);
		$data['created_user_id'] = $request->header('x-user');
		$obj = new limits($data);
		$obj->save();
		return response()->json($obj);
	}

	public function delete($id, Request $request)
	{
		$obj = limits::destroy($id);
		return response(200);
	}

	public function get(Request $request)
	{
		return response(200);
	}

	public function getById($id, Request $request)
	{
		$OD = OD::find($id);
		$device = $OD->tbl_name::find($OD->device_id);
		$allLimits = limits::where('device_id', $OD->device_id)
			->where('tbl_name', $OD->tbl_name)
			->get();
		$currentLimits = ODRL::where('object_device_id', $id)->get();
		return response()->json([
			'allLimits' => $allLimits,
			'currentLimits' => $currentLimits,
			'device' => $device,
		]);
	}

	public function setById($id, Request $request)
	{
		$is_good = false;
		$object_device_id = $id;
		$allLimits = $request->input('allLimits');
		$additionalLimits = $request->input('additionalLimits');
		$limitations = [];
		$created_user_id = $request->header('x-user');
		foreach ($allLimits as $key => $value) {
			$limitations[$value['id']] = $value['checked'];
		}
		$is_good = !(in_array(true, array_values($limitations)) || $additionalLimits);
		// get all limitated objects
		$ODRL_objects = ODRL::withTrashed()
			->where('object_device_id', $id)
			->whereIn('DL_id', array_keys($limitations))
			->get();
		// check all limited objects for intercept with requested limits
		foreach ($ODRL_objects as $ODRL_object) {
			if ($limitations[$ODRL_object->DL_id]) { // limited objects intercept with requested limits
				$ODRL_object->restore(); // resore limited object
			} else {
				$ODRL_object->delete(); // delete limited object
			}
			unset($limitations[$ODRL_object->DL_id]);
		}
		if (count($limitations) > 0) {
			foreach ($limitations as $key => $value) {
				$data = [
					'created_user_id' => $created_user_id,
					'object_device_id' => $id,
					'DL_id' => $key,
				];
				$ODRL_object = new ODRL($data);
				$ODRL_object->save();
				if (!$value)
					$ODRL_object->delete();
			}
		}

		//additional limitation
		if ($additionalLimits && count($additionalLimits) > 0) {
			foreach ($additionalLimits as $addLimit) {
				$data = [
					'created_user_id' => $created_user_id,
					'object_device_id' => $id,
					'additional_limitation' => $addLimit['additionalLimit'],
					'additional_limitation_critical' => $addLimit['isCritical'],
				];

				$isTempId = substr( $addLimit['id'], 0, 6 ) === 'tempid';

				if ($isTempId) {
					$ODRL_object = new ODRL($data);
					$ODRL_object->save();
				} else {
					$obj = ODRL::find($addLimit['id']);
					$obj->update($data);
				}
			}
		}

		return response($is_good ? 1 : 0, 200);
	}
}
