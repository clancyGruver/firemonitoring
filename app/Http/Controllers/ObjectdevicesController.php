<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Object_Device as OD;
use Illuminate\Support\Facades\Auth;
use App\WorkType;


class ObjectdevicesController extends Controller
{
    public function storeCoordsJson($id, Request $request){
        $obj = OD::find($id);
        $data = $request->only(['lat', 'lng', 'bti_files_id']);
        $data['created_user_id'] = $request->header('x-user');
        $obj->update($data);
        return response()->json($obj);
    }
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

    public function storeJson(Request $request){
        $data = $request->all();
        $params = [];

        $params['created_user_id'] = $request->header('x-user');
        $params['object_id'] = $data['object_id'];
        $params['device_id'] = $data['device_id'];
        if( isset($data['setup_year']) && $data['setup_year'] )
            $params['setup_year'] = $data['setup_year'];
        if(isset($data['parent_id']) && $data['parent_id']){
            $params['parent_id'] = $data['parent_id'];
        }
        $params['tbl_name'] = $data['tbl_name'];
        $countElements = isset($data['count']) && $data['count'] ? $data['count'] : 1;
        unset($data['count']);
        $result = [];
        for($i=0; $i< $countElements; $i++){
            $obj = new OD($params);
            $obj->save();
            $id = $obj->id;
            $work = new WorkType([
                'object_id' => $obj->object_id,
                'object_device_id' => $obj->device_id,
                'user_id' => $params['created_user_id'],
                'tbl_name' => $obj->tbl_name,
                'work_type' => 'setup'
            ]);
            $work->save();
            $result[] = OD::where('id', $id)
                    ->with('wires')
                    ->with('alerts')
                    ->with('devicable')
                    ->first();
        }
        if($countElements == 1)
            $result = $result[0];

        return response()->json($result);
    }

    public function getJson($id, Request $request){
        $installed_dev_categories = OD::where('object_id',$id)
                                    ->whereNull('parent_id')
                                    ->with('wires')
                                    ->with('alerts')
                                    ->with('devicable')
                                    ->get()
                                    ?? null;
        return response()->json($installed_dev_categories);
    }

    public function deleteJson($id, Request $request){
        $obj = OD::find($id);
        $work = new WorkType([
            'object_id' => $obj->object_id,
            'object_device_id' => $obj->device_id,
            'user_id' => $request->header('x-user'),
            'tbl_name' => $obj->tbl_name,
            'work_type' => 'delete'
        ]);
        $work->save();
        if($obj->tbl_name == 'App\device_aps'){
            foreach ($obj->wires as $wire) {
                $wire->delete();
            }
        }
        $obj->delete();
    }

    public function isgood($id, Request $request){
        $obj = OD::find($id);
        $data = $request->only('is_good');
        $data['created_user_id'] = $request->header('x-user');
        $obj->update($data);
    }

    public function storeSetupYear($id, Request $request){
        $obj = OD::find($id);

        $data = $request->only('setup_year');
        $data['created_user_id'] = $request->header('x-user');
        $obj->update($data);
    }

}
