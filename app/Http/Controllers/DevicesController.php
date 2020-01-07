<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\DeviceClass;
use App\device_aps;
use App\device_antenna;
use App\device_rspi;
use App\device_alert;
use App\device_system_voice_alert;
use App\Sensor;
use App\device_power_supply;
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
        $items = Device_aps::with('get_instruction_path')->all();
        return response()->json($items);
    }

    public function getByClassJson(){
        $antennas = device_antenna::with(['limitations','reglaments'])->get();
        $rspi = device_rspi::with(['limitations','reglaments'])->get();
        $alerts = device_alert::with(['limitations','reglaments'])->get();
        $voice_alerts = device_system_voice_alert::with(['limitations','reglaments'])->get();
        $aps = device_aps::with(['limitations','reglaments'])->get();
        $sensors = Sensor::with(['reglaments'])->get();
        $power_supply = device_power_supply::with(['limitations','reglaments'])->get();
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
            ],
            'sensors' => [
                'name' =>'Извещатели',
                'tbl_name' => 'App\Sensor',
                'devices' => $sensors
            ],
            'power_supply' => [
                'name' =>'Блок питания',
                'tbl_name' => 'App\device_power_supply',
                'devices' => $power_supply
            ],
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

    public function delete($type, $id){
        switch($type){
            case 'antennas':
                device_antenna::destroy($id);
                break;
            case 'rspi':
                device_rspi::destroy($id);
                break;
            case 'aps':
                device_aps::destroy($id);
                break;
            case 'alerts':
                device_alert::destroy($id);
                break;
            case 'voice_alerts':
                device_system_voice_alert::destroy($id);
                break;
            case 'sensors':
                Sensor::destroy($id);
                break;
            case 'power_supply':
                device_power_supply::destroy($id);
                break;
            default: break;
        }
        return response(200);
    }

    public function add($type, Request $request){
        $request->validate([
            'name' => 'required',
        ]);
        $data = $request->all();
        $data['created_user_id'] = Auth::user()->id;
        $obj = null;
        switch($type){
            case 'antennas':
                $obj = new device_antenna($data);
                break;
            case 'rspi':
                $obj = new device_rspi($data);
                break;
            case 'aps':
                $obj = new device_aps($data);
                break;
            case 'alerts':
                $obj = new device_alert($data);
                break;
            case 'voice_alerts':
                $obj = new device_system_voice_alert($data);
                break;
            case 'sensors':
                $obj = new Sensor($data);
                break;
            case 'power_supply':
                $obj = new device_power_supply($data);
                break;
            default: break;
        }
        $obj->save();
        if($request->newFile){
            $file = $request->newFile;
            $fileName = $file->getClientOriginalName();
            $data['instruction'] = $fileName;
            $request->newFile->storeAs('instructions/'.$type.'/'.$obj->id, $fileName);
            $obj->instruction = $data['instruction'];
            $obj->save();
        }
        return response()->json($obj);
    }

    public function update($type, $id, Request $request){
        $data = $request->all();
        $data['created_user_id'] = $request->header('x-user');
        $obj = null;
        switch($type){
            case 'antennas':
                $obj = device_antenna::find($id);
                break;
            case 'rspi':
                $obj = device_rspi::find($id);
                break;
            case 'aps':
                $obj = device_aps::find($id);
                break;
            case 'alerts':
                $obj = device_alert::find($id);
                break;
            case 'voice_alerts':
                $obj = device_system_voice_alert::find($id);
                break;
            case 'sensors':
                $obj = Sensor::find($id);
                break;
            case 'power_supply':
                $obj = device_power_supply::find($id);
                break;
            default: break;
        }
        if($request->newFile){
            $file = $request->newFile;
            $fileName = $file->getClientOriginalName();
            $data['instruction'] = $fileName;
            $request->newFile->storeAs('instructions/'.$type.'/'.$obj->id, $fileName);
        }
        $obj->update($data);
        $obj->save();
        return response()->json($obj);
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
