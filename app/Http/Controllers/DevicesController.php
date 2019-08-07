<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\DeviceClass;
use App\device_aps;
use App\device_antenna;
use App\device_rspi;
use App\device_alert;
use App\device_system_voice_alert;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;


class DevicesController extends Controller
{
    public function index(){
        $items = Device_aps::all();
        for($i =0; $i < count($items); $i++){
            $items[$i]->url = Storage::url('instructions/'.$items[$i]->id.'/'.$items[$i]->instruction);
        }
        return view('admin.devices.index',['items' => $items]);
    }

    public function getJson(){
        $items = Device_aps::all();
        for($i =0; $i < count($items); $i++){
            $items[$i]->url = Storage::url('instructions/'.$items[$i]->id.'/'.$items[$i]->instruction);
        }
        return response()->json($items);
    }

    public function getByClassJson(){
        $antennas = device_antenna::with('limitations')->get();
        $rspi = device_rspi::with('limitations')->get();
        $alerts = device_alert::with('limitations')->get();
        $voice_alerts = device_system_voice_alert::with('limitations')->get();
        $aps = Device_aps::with('limitations')->get();
        $res = [
            'antennas'=> [
                'name' => 'Антенна',
                'tbl_name' => 'App\device_antenna',
                'devices' => $antennas,
            ],
            'rspi'=> [
                'name' => 'Системы передачи извещений о пожаре',
                'tbl_name' => 'App\device_rspi',
                'devices' => $rspi,
            ],
            'aps'=> [
                'name' => 'Охранно-пожарная сигнализация',
                'tbl_name' => 'App\device_aps',
                'devices' => $aps
            ],
            'alerts'=> [
                'name' => 'Оповещатели',
                'tbl_name' => 'App\device_alert',
                'devices' => $alerts
            ],
            'voice_alerts'=> [
                'name' =>'Система речевого оповещения',
                'tbl_name' => 'App\device_system_voice_alert',
                'devices' => $voice_alerts
            ]
        ];

        return response()->json($res);
    }

    public function detail($id, Request $request){
        $item = Device_aps::find($id);
        return view('admin.devices',['item' => $item]);
    }

    public function edit($id, Request $request){
        $item = Device_aps::find($id);
        $item->url = Storage::url('instructions/'.$item->id.'/'.$item->instruction);
        return view('admin.devices.edit',['item' => $item]);
    }

    public function delete($id, Request $request){
        $item = Device_aps::destroy($id);
    }

    public function add(Request $request){
        return view('admin.devices.add');
    }

    public function update($id, Request $request){
        $request->validate([
            'fileToUpload' => 'file',
            'name' => 'required',
            'wires_count' => 'required',
        ]);
        $obj = Device_aps::find($id);
        $params = $request->except(['id','_token']);
        if($request->instruction){
            $params['instruction'] = $request->instruction->getClientOriginalName();
            $request->instruction->storeAs('instructions/ops/'.$obj->id, $request->instruction->getClientOriginalName());
        }
        $params['created_user_id'] = Auth::user()->id;
        $obj->update($params);
        return redirect('admin/devices');
    }

    public function store( Request $request){
        $validatedData = $request->validate([
            'name' => 'required',
            'wires_count' => 'required',
        ]);
        $obj = new Device_aps($request->except('_token'));
        $obj->created_user_id = Auth::user()->id;
        $obj->save();
        if($request->instruction){
            $obj->instruction = $request->instruction->getClientOriginalName();
            $request->instruction->storeAs('instructions/ops/'.$obj->id, $request->instruction->getClientOriginalName());
        }
        $obj->save();
        return redirect('admin/devices');
    }
}
