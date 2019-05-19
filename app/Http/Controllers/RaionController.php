<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Raion;

class RaionController extends Controller
{
    public function index(){
        return response(Raion::all()->jsonSerialize());
    }
    public function update($id, Request $request){
        
      $raion = Raion::find($id);

      $raion->update($request->all());

      dd($request->all());

      return response()->json('successfully updated');
    }
}
