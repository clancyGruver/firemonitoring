<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\CableType;

class CableTypeController extends Controller
{
    public function index(){
    	$objects = CableType::all();
    	return response()->json($objects);
    }

    public function add(Request $request){
    	$data = $request->all();
    	$obj = new CableType($data);
    	$obj->save();
    	return response()->json($obj);
    }
}
