<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use PhpOffice\PhpWord\TemplateProcessor;
use App\MonitoringObject as MO;
use Illuminate\Support\Facades\Auth;
use App\Object_Device as OD;

class WordController extends Controller
{
    private $break = '</w:t><w:br/><w:t>';
    public function serviceabilityAct($object_id, Request $request){
        /*init*/

        $object = MO::find($object_id);
        $date = new \DateTime();

        $dateMinusTenYears = new \DateTime();
        $dateMinusTenYears = $dateMinusTenYears->sub(new \DateInterval('P10Y'));
        $devices = OD::where('object_id', $object_id)->get();

        /* check defects */
        $devices_tenYearsSetup = $devices->filter( function($device) use ($dateMinusTenYears) {
            return !is_null($device->setup_year) && $device->setup_year < $dateMinusTenYears->format('Y');
        } );
        
        $devices_bad = $devices->filter( function($device) {
            return $device->is_good === 0;
        } );

        $aps = $devices->filter( function($device) {
            return $device->tbl_name === 'App\device_aps';
        } );

        $sensors_bad = 0;
        $sp_5 = 0;
        foreach($aps as $aps_device){
            foreach($aps_device->wires as $wire){
                $bad_counted = $wire->sensors->countBy(function ($sensor) {
                    return $sensor->is_good === 0 ? 'bad' : 'good';
                });
                $sp5_counted = $wire->sensors->countBy(function ($sensor) {
                    return $sensor->SP5_valid === 0 ? 'bad' : 'good';
                });
                $sensors_bad += isset($bad_counted['bad']) && !empty($bad_counted['bad']) ? $bad_counted['bad'] : 0;
                $sp_5 += isset($sp5_counted['bad']) && !empty($sp5_counted['bad']) ? $sp5_counted['bad'] : 0;
            }
        }
        /* fill $defects */
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

        $templateProcessor->saveAs(public_path('Акт исправности.docx'));

        return response(200);
        //return response()->download(public_path('Акт исправности.docx'));
    }
}
