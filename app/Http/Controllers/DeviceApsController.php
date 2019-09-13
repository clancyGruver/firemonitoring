<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class DeviceApsController extends Controller
{
    public function getJson(){
        $items = Device_aps::with('get_instruction_path')->all();
        return response()->json($items);
    }
}
