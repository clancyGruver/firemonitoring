<?php

namespace App\Http\Controllers;

use App\power_supply;
use Illuminate\Http\Request;
use App\device_power_supply as DPS;
use Illuminate\Support\Facades\Auth;

class DevicePowerSupplyController extends Controller
{
    public function index(){
        $items = DPS::all();
        return response()->json($items);
    }

    public function detail($id, Request $request){
        $item = DPS::find($id);
        return response()->json($item);
    }

    public function delete($id, Request $request){
        DPS::destroy($id);
        return response(200);
    }

    public function store( Request $request){
        $validatedData = $request->validate([
            'name' => 'required',
        ]);
        $obj = new DPS($request->except('_token'));
        $obj->created_user_id = Auth::user()->id;
        $obj->save();
        if($request->instruction){
            $obj->instruction = $request->instruction->getClientOriginalName();
            $request->instruction->storeAs('instructions/power_supply/'.$obj->id, $request->instruction->getClientOriginalName());
            $obj->save();
        }
        return response()->json($obj);
    }

    public function update($id, Request $request){
        $params = $request->all();
        $params['created_user_id'] = Auth::user()->id;
        $item = DPS::find($id);
        $item->update($params);
    }
}
