<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Object_Device as OD;
use Illuminate\Support\Facades\Auth;


class ObjectdevicesController extends Controller
{
    public function store(Request $request){
        $data = $request->all();
        $params = [];
        $params['created_user_id'] = Auth::user()->id;
        $obj_id = $data['object_id'][0];
        $params['object_id'] = $obj_id;
        foreach($data['device_id'] as $v){            
            $params['device_id'] = $v;
            $obj = new OD($params);
            $obj->save();
        }
        return redirect("admin/objects/edit/{$obj_id}");
    }

    public function getJson($id, Request $request){
        $installed_dev_categories = OD::where('is_active',1)->where('object_id',$id)->with('device')->get() ?? null;
        return response()->json($installed_dev_categories);
    }
}
