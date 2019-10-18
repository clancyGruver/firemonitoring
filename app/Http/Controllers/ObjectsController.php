<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use App\MonitoringObject as MO;
use Illuminate\Support\Facades\Auth;
use App\Raion;
use App\Object_Device as OD;
use App\ObjectMediafile as OMedia;
use App\bti_files as BTI;
use App\DistrictUser;

class ObjectsController extends Controller
{
    public function index(){
        return view('admin.objects.index');
    }

    public function indexJson(Request $request){
        if($request->user()->is_admin){
            $items = MO::with(['raion', 'btifiles', 'mediafiles', 'district'])->get();
        }
        else{
            $items = [];
            $user_districts = DistrictUser::where('user_id',$request->user()->id)->get();
            foreach ($user_districts as $user_district) {
                foreach ($user_district->district->objectsFull as $monitoringObject) {
                    $items[] = $monitoringObject->toArray()['object_full'];
                }
            }
        }
        return response()->json($items);
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
        $item = MO::find($id)->delete();
        return response(200);
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
        ]);
        $obj = MO::find($id);
        $params = $request->all();
        $param['created_user_id'] = Auth::user()->id;
        $params['project_isset'] = isset($params['project_isset']) ? 1 : 0;
        $obj->update($params);
        return redirect('admin/objects');
    }

    public function updateJson($id, Request $request){
        $validatedData = $request->validate([
            'name' => 'required',
            'raion_id' => 'required',
            'address' => 'required|max:255|nullable',
            'director_name' => 'required|max:255|nullable',
            'director_phone' => 'required|max:255|nullable',
            'contact_name' => 'required|max:255|nullable',
            'contact_phone' => 'required|max:255|nullable',
        ]);
        $obj = MO::find($id);
        $params = $request->all();
        $params['created_user_id'] = $request->header('x-user');
        $params['project_isset'] = isset($params['project_isset']) ? 1 : 0;
        $obj->update($params);
    }

    public function addObject( Request $request){
        $validatedData = $request->validate([
            'name' => 'required',
            'raion_id' => 'required',
            'address' => 'required|max:255',
            'director_name' => 'required|max:255',
            'director_phone' => 'required|max:255',
            'contact_name' => 'required|max:255',
            'contact_phone' => 'required|max:255',
        ]);
        $params = $request->except('_token');
        $params['project_isset'] = isset($params['project_isset']) ? 1 : 0;
        $obj = new MO($params);
        $obj->created_user_id = $request->header('x-user');
        $obj->save();
        $resp = MO::where('id',$obj->id)->with('raion')->with('btifiles')->with('mediafiles')->first();
        return response()->json($resp);
    }

    public function fileUpload( Request $request){
        if($request->image){
            $params = [];
            $params['filename'] = $request->image->getClientOriginalName();
            $params['description'] = $request->description ? $request->description : $params['filename'];
            $params['created_user_id'] = $request->header('x-user');
            $params['object_id'] = $request->object_id;
            $request->image->storeAs('objectMedia/'.$request->object_id, $request->image->getClientOriginalName());
            $obj = new OMedia($params);
            $obj->save();
            return response()->json($obj);
        }
        return response(403);
    }

    public function btiUpload( Request $request){
        if($request->image){
            $params = [];
            $params['filename'] = $request->image->getClientOriginalName();
            $params['description'] = $request->description ? $request->description : $params['filename'];
            $params['object_id'] = $request->object_id;
            $params['created_user_id'] = $request->header('x-user');
            $request->image->storeAs('bti/'.$request->object_id, $request->image->getClientOriginalName());
            $obj = new BTI($params);
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

    public function btiDelete($id, Request $request){
        $obj = BTI::find($id);
        $obj->delete();
        return response()->json(200);
    }

    public function btiFiles($id, Request $request){
        $items = BTI::where('object_id',$id)->get();
        return response()->json($items);
    }

    public function storeCoords($id, Request $request){
        $item = MO::find($id);
        $item->update($request->all());
        return response('ok', 200);
    }

    public function limited(Request $request){
        $ids = $request->only('objectsIds');
        $ids = $ids['objectsIds'];
        $sensors = DB::select('
            SELECT DISTINCT(`object_id`)
            FROM `object_devices`
            WHERE id in (
                SELECT DISTINCT(`object_device_id`)
                FROM `wires`
                WHERE `id` in (
                    SELECT DISTINCT(`wire_id`)
                    FROM `wire_sensor`
                    WHERE `is_good` = 0
                )
            )
        ');
        $sp5 = DB::select('
            SELECT DISTINCT(`object_id`)
            FROM `object_devices`
            WHERE id in (
                SELECT DISTINCT(`object_device_id`)
                FROM `wires`
                WHERE `id` in (
                    SELECT DISTINCT(`wire_id`)
                    FROM `wire_sensor`
                    WHERE `SP5_valid` = 0
                )
            )
        ');
        $devices = DB::select('
            SELECT DISTINCT(`object_id`)
            FROM `object_devices`
            WHERE `is_good` = 0
        ');
        $filterFunc = function($obj) use ($ids){
            return in_array($obj->object_id, $ids);
        };
        $mapFunc = function($obj){ return $obj->object_id; };
        $items = [
            'sensors' => array_map($mapFunc, array_values(array_filter($sensors, $mapFunc))),
            'devices' => array_map($mapFunc, array_values(array_filter($devices, $mapFunc))),
            'sp5'     => array_map($mapFunc, array_values(array_filter($sp5, $mapFunc))),
        ];
        return response()->json($items);
    }
}
