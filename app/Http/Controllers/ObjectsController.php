<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\MonitoringObject as MO;
use Illuminate\Support\Facades\Auth;
use App\Raion;
use App\DeviceClass;
use App\Object_Device as OD;
use App\ObjectMediafile as OMedia;

class ObjectsController extends Controller
{
    public function index(){
        $items = MO::where('is_active',1)->get();
        return view('admin.objects.index',['items' => $items]);
    }

    public function edit($id, Request $request){
        $item = MO::where('id',$id)->with('mediafiles')->first();
        $raions = Raion::where('is_active',1)->get();
        return view('admin.objects.edit',[
            'item' => $item,
            'raions'=>$raions,
        ]);
    }

    public function detail($id, Request $request){
        //$item = MO::find($id)->with('mediafiles');
        $item = MO::where('id',$id)->with('mediafiles')->first();
        return view('admin.objects.detail',['item' => $item]);
    }

    public function delete($id, Request $request){
        $item = MO::find($id);
        $item->is_active = 0;
        $item->save();
    }

    public function add(Request $request){
        $raions = Raion::where('is_active',1)->get();
        return view('admin.objects.add',['raions'=>$raions]);
    }

    public function update($id, Request $request){
        $validatedData = $request->validate([
            'lat' => 'required',//|unique:posts|max:255
            'lng' => 'required',
            'name' => 'required',
            'raion_id' => 'required',
            'address' => 'required|max:255',
            'director_name' => 'required|max:255',
            'director_phone' => 'required|max:255',
            'contact_name' => 'required|max:255',
            'contact_phone' => 'required|max:255',
            'project_year'=>'digits:4',
        ]);
        $obj = MO::find($id);
        $params = $request->all();
        $params['project_isset'] = isset($params['project_isset']) ? 1 : 0;
        $param['created_user_id'] = Auth::user()->id;
        $obj->update($params);
        return redirect('admin/objects');
    }

    public function store( Request $request){
        $validatedData = $request->validate([
            'lat' => 'required',
            'lng' => 'required',
            'name' => 'required',
            'raion_id' => 'required',
            'address' => 'required|max:255',
            'director_name' => 'required|max:255',
            'director_phone' => 'required|max:255',
            'contact_name' => 'required|max:255',
            'contact_phone' => 'required|max:255',
            'project_year'=>'digits:4',
        ]);
        $params = $request->except('_token');
        $params['project_isset'] = isset($params['project_isset']) ? 1 : 0;
        $obj = new MO($params);
        $obj->created_user_id = Auth::user()->id;
        $obj->save();
        return redirect('admin/objects');
    }

    public function fileUpload( Request $request){
        if($request->file){
            $params = [];
            $params['filename'] = $request->file->getClientOriginalName();
            $params['description'] = $request->description ? $request->description : $params['filename'];
            $params['object_id'] = $request->object_id;
            $request->file->storeAs('objectMedia/'.$request->object_id, $request->file->getClientOriginalName());
            $obj = new OMedia($params);
            $obj->save();
            return response()->json($obj);
        }
        return response(403);
    }

    public function fileDelete($id, Request $request){   
        $obj = OMedia::find($id);
        $obj->delete();
        return response()->json(200);
    }
}
