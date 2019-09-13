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
        $raions = Raion::withTrashed()->get();
        return response()->json($raions);
    }

    public function update($id, Request $request){
      $raion = Raion::withTrashed()->find($id);
      if(is_null($raion->deleted_at))
        $raion->delete();
      else
        $raion->restore();
      return response(200);
    }
}
