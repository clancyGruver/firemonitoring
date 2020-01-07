<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\DeviceClass as DC;
use Illuminate\Support\Facades\Auth;


class DevicesClassesController extends Controller
{
    public function index(){
        $items = DC::all();
        return view('admin.deviceClasses.index',['items' => $items]);
    }

    public function add(Request $request){
        return view('admin.deviceClasses.add');
    }

    public function update($id, Request $request){
        $item = DC::find($id);
        $item->update($request->all());
        return response()->json('successfully updated');
    }

    public function store( Request $request){
        $validatedData = $request->validate([
            'name' => 'required',
        ]);
        $obj = new DC($request->except('_token'));  
        $obj->save();
        return redirect('admin/devicesClasses');
    }
}
