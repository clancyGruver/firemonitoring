<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\device_aps_params as DAP;
use Illuminate\Support\Facades\Auth;

class DeviceApsController extends Controller
{
    public function getJson(){
        $items = Device_aps::with('get_instruction_path')->all();
        return response()->json($items);
    }

    public function storeParams(Request $request){
        $params = $request->all();
        $params['created_user_id'] = Auth::user()->id;
        if(isset($params['id'])){
            $item = DAP::find($params['id']);
            $item->update($params);
        }
        else{
            $item = new DAP($params);
            $item->save();
        }
    }
}
