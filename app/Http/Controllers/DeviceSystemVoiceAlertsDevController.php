<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\device_system_voice_alerts_dev as DSVAD;
use App\device_system_voice_alert_params as DSVAP;


class DeviceSystemVoiceAlertsDevController extends Controller
{
	public function store(Request $request){
        $params = $request->all();
        $params['created_user_id'] = $request->header('x-user');
        $item = new DSVAD($params);
        $item->save();
	}
	public function storeCoords($id, Request $request){
        $obj = DSVAD::find($id);
        $data = $request->only(['lat', 'lng', 'bti_files_id']);
        $data['created_user_id'] = $request->header('x-user');
        $obj->update($data);
        return response()->json($obj);
    }
}
