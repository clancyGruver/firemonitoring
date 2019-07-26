<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Raion;

class RaionController extends Controller
{
    public function index(){
        $raions = Raion::all();
        return view('admin.raions',['raions' => $raions]);

    }

    public function indexJson(Request $request){
        $raions = Raion::where('is_active',1)->get();
        return response()->json($raions);
    }

    public function update($id, Request $request){
      $raion = Raion::find($id);
      $raion->update($request->all());
      return response()->json('successfully updated');
    }
}
