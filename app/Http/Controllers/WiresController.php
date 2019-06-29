<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Wire;


class WiresController extends Controller
{
    public function storeJson(Request $request){
        $data = $request;
        $params = [];

        $params['created_user_id'] = $data['user_id'];
        $params['object_device_id'] = $data['object_device_id'];
        foreach ($data['wire_data'] as $key => $value) {
            if($key == 'type') continue;
            $params[$key] = $value;
        }
        $obj = new Wire($params);
        $obj->save();

        return response()->json($obj);
    }

    public function getJson($id, Request $request){
        $installed_dev_categories = OD::where('is_active',1)->where('object_id',$id)->with('device')->get() ?? null;
        return response()->json($installed_dev_categories);
    }

    public function updateJson($id, Request $request){
        $data = $request->all();
        $params = [];

        $params['created_user_id'] = $data['user_id'];
        $params['is_good'] = $data['is_good'];
        $params['description'] = $data['description'];
        $params['type'] = $data['type'];
        $params['sertificate'] = $data['sertificate'];

        $obj = Wire::find($id);
        $obj->update($params);

        return response()->json($obj);
    }

    public function deleteJson($id, Request $request){
        $obj = Wire::find($id)->delete();

        return response()->json($obj);
    }
}
