<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use PhpOffice\PhpWord\TemplateProcessor;
use App\MonitoringObject as MO;
use Illuminate\Support\Facades\Auth;
use App\Object_Device as OD;
use App\ObjectMediafile as OMedia;
use App\Repositories\Serviceability;

class WordController extends Controller
{
    private $break = '</w:t><w:br/><w:t>';

    public function serviceabilityAct($object_id, Request $request){
        $service = new Serviceability($object_id);
        $service->defects();
        $service->printDevices();
       /* 
        // fill $defects 
        $defects = 'Без недостатков';
        $haveDefects = $devices_tenYearsSetup->count() > 0 
                        || $devices_bad->count() > 0
                        || $sensors_bad > 0
                        || $sp_5 > 0;
        if($haveDefects){
            $defects = '';
            if($devices_tenYearsSetup->count() > 0 ){
                $defects .= "Оборудование установлено более 10 лет назад:" . $this->break;
                foreach($devices_tenYearsSetup as $device){
                    $defects .= $device->tbl_name::find($device->device_id)->name . $this->break;
                }
            }
            if($devices_bad->count() > 0 ){
                $defects .= "Оборудование в неисправном состоянии:" . $this->break;
                foreach($devices_bad as $device){
                    $defects .= $device->tbl_name::find($device->device_id)->name . $this->break;
                }
            }
            if($sensors_bad > 0 ){
                $defects .= 'Извещетелей в неисправном состоянии: ' . $sensors_bad . $this->break;
            }
            if($sp_5 > 0 ){
                $defects .= 'Извещетелей установлено не в соответствии с СП 5: ' . $sp_5 . $this->break;
            }
        }
        
        $file = '../storage/word_templates/serviceabilityAct.docx';
        $director = $object->director_name;
        $technick = Auth::user()->name;
        $object_name = $object->name;
        $object_address = $object->address;

        $templateProcessor = new TemplateProcessor($file);

        $templateProcessor->setValues([
            'year'           => $date->format('Y'),
            'director_fio'   => $director,
            'technick_fio'   => $technick,
            'object_name'    => $object_name,
            'object_address' => $object_address,
            'defects'        => $defects,
        ]);

        $resultFileName = 'Акт исправности ' . $date->format('d-m-Y') . '.docx';

        $outputDir = public_path('uploads/objectMedia/'.$object_id . '/' . $resultFileName);
        if(!is_dir($outputDir)){
            mkdir($outputDir, 0777, true);
        }
        $templateProcessor->saveAs($outputDir);

        $params = [];
        $params['filename'] = $resultFileName;
        $params['description'] = $resultFileName;
        $params['created_user_id'] = Auth::user()->id;
        $params['object_id'] = $object_id;
        $mediaObj = new OMedia($params);
        $mediaObj->save();

        return response()->json($mediaObj);*/
        //return response()->download(public_path('Акт исправности.docx'));
    }
}
