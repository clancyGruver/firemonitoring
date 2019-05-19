<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\MonitoringObject as MO;
use Illuminate\Support\Facades\Auth;
use App\Raion;

class ObjectsController extends Controller
{
    public function index(){
        return response(MO::all()->jsonSerialize());
    }

    public function getOne($id, Request $request){        
      return response(MO::find($id)->jsonSerialize());
    }

    public function update($id, Request $request){
        $obj = MO::find($id);
        $params = $request->all();
        $param['created_user_id'] = Auth::user()->id;
        $obj->update($params);
        return response()->json('successfully updated');
    }

    public function create( Request $request){
        $obj = new MO;  
        foreach($request->all() as $k=>$v)
            $obj[$k] = $v;
        $raion = Raion::find($obj['raion_id']);
        $coords = $obj->get_coords("{$raion->lng} {$raion->lat}", "{$raion->name}, {$obj['address']}");
        foreach($coords as $k=>$v){
            $obj[$k] = $v;
        }
        //dd(Auth::user());
        //$obj->created_user_id = Auth::user()->id;
        $obj->save();
        return response($obj->jsonSerialize());
    }
}
