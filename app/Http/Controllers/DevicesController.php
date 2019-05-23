<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Device;
use App\DeviceClass;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;


class DevicesController extends Controller
{
    public function index(){
        $items = Device::where('is_active',1)->get();
        for($i =0; $i < count($items); $i++){
            $items[$i]->url = Storage::url('instructions/'.$items[$i]->id.'/'.$items[$i]->instruction);
        }
        return view('admin.devices.index',['items' => $items]);
    }

    public function detail($id, Request $request){        
        $item = Device::find($id);
        return view('admin.devices',['item' => $item]);
    }

    public function edit($id, Request $request){        
        $item = Device::find($id);
        $DC = DeviceClass::where('is_active',1)->get();
        $item->url = Storage::url('instructions/'.$item->id.'/'.$item->instruction);
        return view('admin.devices.edit',['item' => $item, 'classes'=>$DC]);
    }

    public function delete($id, Request $request){        
        $item = Device::find($id);
        $item->is_active = 0;
        $item->save();
    }

    public function add(Request $request){
        $DC = DeviceClass::where('is_active',1)->get();
        return view('admin.devices.add',['classes'=>$DC]);
    }

    public function update($id, Request $request){
        $request->validate([
            'fileToUpload' => 'file',
            'name' => 'required',
            'class_id' => 'required',
            'wires_count' => 'required',
        ]);
        $obj = Device::find($id);
        $params = $request->except(['id','_token']);
        if($request->instruction){
            $params = $request->instruction->getClientOriginalName();
            $request->instruction->storeAs('instructions/'.$obj->id, $request->instruction->getClientOriginalName());    
        }
        $params['created_user_id'] = Auth::user()->id;
        $obj->update($params);
        return redirect('admin/devices');
    }

    public function store( Request $request){
        $validatedData = $request->validate([
            'name' => 'required',
            'class_id' => 'required',
            'wires_count' => 'required',
        ]);
        $obj = new Device($request->except('_token'));
        $obj->instruction = $request->instruction->getClientOriginalName();
        $obj->created_user_id = Auth::user()->id;
        $obj->save();
        $request->instruction->storeAs('instructions/'.$obj->id, $request->instruction->getClientOriginalName());
        return redirect('admin/devices');
    }
}
