<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\device_system_voice_alert as SVA;
use App\device_system_voice_alert_params as SVAP;
use Illuminate\Support\Facades\Auth;

class DeviceSystemVoiceAlertController extends Controller
{
    public function index(){
        $items = SVA::all();
        return view('admin.sys_alert.index',['items' => $items]);
    }

    public function getJson(){
        $items = SVA::all();
        return response()->json($items);
    }

    public function detail($id, Request $request){
        $item = SVA::find($id);
        return view('admin.sys_alert',['item' => $item]);
    }

    public function edit($id, Request $request){
        $item = SVA::find($id);
        return view('admin.sys_alert.edit',['item' => $item]);
    }

    public function delete($id, Request $request){
        SVA::destroy($id);
    }

    public function add(Request $request){
        return view('admin.sys_alert.add');
    }

    public function update($id, Request $request){
        $request->validate([
            'name' => 'required',
        ]);
        $obj = SVA::find($id);
        $params = $request->except(['id','_token']);
        if($request->instruction){
            $params['instruction'] = $request->instruction->getClientOriginalName();
            $request->instruction->storeAs('instructions/sys_alert/'.$obj->id, $request->instruction->getClientOriginalName());
        }
        $params['created_user_id'] = Auth::user()->id;
        $obj->update($params);
        return redirect('admin/sys_alert');
    }

    public function store( Request $request){
        $validatedData = $request->validate([
            'name' => 'required',
        ]);
        $obj = new SVA($request->except('_token'));
        $obj->created_user_id = Auth::user()->id;
        $obj->save();
        if($request->instruction){
            $obj->instruction = $request->instruction->getClientOriginalName();
            $request->instruction->storeAs('instructions/sys_alert/'.$obj->id, $request->instruction->getClientOriginalName());
        }
        $obj->save();
        return redirect('admin/sys_alert');
    }

    public function storeParams(Request $request){
        $params = $request->all();
        $params['created_user_id'] = Auth::user()->id;
        if(isset($params['id'])){
            $item = SVAP::find($params['id']);
            $item->update($params);
        }
        else{
            $item = new SVAP($params);
            $item->save();
        }
    }
}
