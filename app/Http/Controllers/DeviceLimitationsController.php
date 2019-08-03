<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\DeviceClass;

class DeviceLimitationsController extends Controller
{
    public function index(){
        return view('admin.objects.index');
    }

    public function indexJson(){
        $items = DeviceClass::where('is_active',1)->with('devices')->get();
        return response()->json($items);
    }
}
