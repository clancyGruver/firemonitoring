<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Wire;


class WiresController extends Controller
{
    public function storeJson(Request $request){
        $data = $request->all();
        $params = [];

        $params['created_user_id'] = $data['user_id'];
        $params['object_device_id'] = $data['object_device_id'];
        foreach ($data['wire_data'] as $key => $value) {
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
}
