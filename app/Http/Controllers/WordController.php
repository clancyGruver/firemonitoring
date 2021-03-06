<?php

namespace App\Http\Controllers;

use App\MonitoringObject as MO;
use App\Object_Device as OD;

use App\Repositories\Serviceability;
use App\Repositories\WordWriter;

class WordController extends Controller
{
        public function serviceabilityAct($object_id){
        $service = new Serviceability($object_id);
        $service->defects();
//        $service->printDevices();

        $template = $service->getTemplateName();
        $resultFileName = $service->getResultPath();

        $writer = new WordWriter($template, $resultFileName);
        $mediaObj = $writer->serviceReportAct($service);
        return response()->json($mediaObj);
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

        $templateProcessor->saveAs($outputDir);


        return response()->json($mediaObj);*/
        //return response()->download(public_path('Акт исправности.docx'));
    }
}
