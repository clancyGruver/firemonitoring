<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\District;
use App\DistrictUser;
use App\DistrictObject;

class DistrictController extends Controller
{
    public function index(){
        $obj = District::with(['objects','users'])->get();
        return response()->json($obj);
    }

    public function store(Request $request){
        $data = $request->only('name');
        $obj = new District($data);
        $obj->save();
        return response()->json($obj);
    }

    public function update($id, Request $request){
        $data['name'] = $request->only('name');
        $obj = District::find($id);
        if(!$obj){
            $obj = new District($data);
            $obj->save();
        } else{
            $obj->update();
        }
        return response()->json($obj);
    }

    public function delete($id){
        $obj = District::delete($id);
        return response(200);
    }

    public function setUser($id, Request $request){
        $data = [];
        $data['user_id'] = $request->only('user_id');
        $data['district_id'] = $id;
        $obj = new DistrictUser($data);
        $obj->save();
        return response()->json($obj);
    }
    public function updateUser($id, Request $request){
        $data = [];
        $data['user_id'] = $request->only('user_id');
        $data['district_id'] = $id;
        $obj = DistrictUser::find($id);
        if(!$obj){
            $obj = new DistrictUser($data);
            $obj->save();
        } else {
            $obj->update();
        }
        return response()->json($obj);
    }
    public function deleteUser($id){
        $obj = DistrictUser::delete($id);
        return response(200);
    }

    public function setObject($id, Request $request){
        $data = [];
        $data['object_id'] = $request->only('object_id');
        $data['district_id'] = $id;
        $obj = new DistrictObject($data);
        $obj->save();
        return response()->json($obj);
    }
    public function updateObject($id, Request $request){
        $data = [];
        $data['object_id'] = $request->only('object_id');
        $data['district_id'] = $id;
        $obj = DistrictObject::find($id);
        if(!$obj){
            $obj = new DistrictObject($data);
            $obj->save();
        } else {
            $obj->update();
        }
        return response()->json($obj);
    }
    public function deleteObject($id, Request $request){
        $obj = DistrictObject::delete($id);
        return response(200);
    }
}
