<?php 
namespace App\Repositories;

use PhpOffice\PhpWord\TemplateProcessor;
use Illuminate\Support\Facades\Auth;
use App\ObjectMediafile as OMedia;

class WordWriter{
    private $lineBreak = '</w:t><w:br/><w:t>';

    private $templateFile = null;
    private $outputFile = null;

    public function __construct($template, $output){
        $this->templateFile = $template;
        $this->outputFile = $output;
    }

    private function saveServiceReportAct($file, $userId, $objectId){
        $params = [];
        $params['filename'] = $file;
        $params['description'] = $file;
        $params['created_user_id'] = $userId;
        $params['object_id'] = $objectId;
        $mediaObj = new OMedia($params);
        $mediaObj->save();
        return $mediaObj;
    }

    public function serviceReportAct(\App\Repositories\Serviceability $serv){
        $auth = Auth::user();
        $technick = $auth->name;
        
        $templateProcessor = new TemplateProcessor($this->templateFile);

        $templateProcessor->setValues([
            'year'           => $serv->getcurrentYear(),
            'director_fio'   => $serv->getDirector(),
            'technick_fio'   => $technick,
            'object_name'    => $serv->getObjectName(),
            'object_address' => $serv->getAddress(),
            'devices'        => $this->createWordListDevices($serv->getDeviceList()),
            'rspis'          => $this->createWordListDevices($serv->getRspiList()),
            'devices_defects'=> $this->createWordListDefects($serv->getDeviceDefects()),
            'rspis_defects'  => $this->createWordListDefects($serv->getRspiDefects()),
            'devices_critical_defects'=> $this->createWordListDefects($serv->getDeviceCriticalDefects()),
            'rspis_critical_defects'  => $this->createWordListDefects($serv->getRspiCriticalDefects()),
        ]);
        $oMedia = $this->saveServiceReportAct($serv->getResultFileName(), $auth->id, $serv->getObjectId(), );

        $templateProcessor->saveAs($this->outputFile);
        return $oMedia;
    }

    private function createWordListDevices($list){
        $resultStrring = "";
        foreach($list as $device){
            $resultStrring .= $this->textLine($device);
        }
        return $resultStrring;
    }

    private function createWordListDefects($list){
        $resultStrring = "";
        $list->each(function($device) use(&$resultStrring){
            if($device['elements']->count() == 0 )
                return;
            $resultStrring .= $this->textLine($device['name']);
            $device['elements']->each(function($elementList, $elementName) use(&$resultStrring){
                $resultStrring .= $this->textLine($elementName, 1);
                foreach($elementList as $element){
                    $resultStrring .= $this->textLine($element, 2);
                }
            });
        });
        return $resultStrring;
    }

    private function textLine($text, $tabCount = 0){
        $resultStrring = '';
        $resultStrring .= str_repeat("\t", $tabCount);
        $resultStrring .= $text;
        $resultStrring .= $this->lineBreak;
        return $resultStrring;
    }



}