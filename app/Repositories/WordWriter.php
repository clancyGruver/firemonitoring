<?php 
namespace App\Repositories;

use PhpOffice\PhpWord\TemplateProcessor;
use Illuminate\Support\Facades\Auth;

class WordWriter{
    private $lineBreak = '</w:t><w:br/><w:t>';

    private $templateFile = null;
    private $outputFile = null;

    public function __construct($template, $output){
        $this->templateFile = $template;
        $this->outputFile = $output;
    }

    public function serviceReportAct(\App\Repositories\Serviceability $serv){
        $technick = Auth::user()->name;
        
        $templateProcessor = new TemplateProcessor($this->templateFile);

        $templateProcessor->setValues([
            'year'           => $serv->getcurrentYear(),
            'director_fio'   => $serv->getDirector(),
            'technick_fio'   => $technick,
            'object_name'    => $serv->getObjectName(),
            'object_address' => $serv->getAddress(),
            'devices'        => $serv->getDeviceList(),
            'rspis'          => $serv->getRspiList(),
            'devices_defects'=> createWordList($serv->getDeviceDefects()),
            'rspis_defects'  => createWordList($serv->getRspiDefects()),
            'devices_critical_defects'=> createWordList($serv->getDeviceCriticalDefects()),
            'rspis_critical_defects'  => createWordList($serv->getRspiCriticalDefects()),
        ]);
    }

    private function createWordListDefects($list){
        $resultStrring = "";
        $list->each(function($device) use(&$resultStrring){
            $resultStrring .= $this->textLine($device['name']);
            $device['elements']->each(function($elementList, $elementName) use(&$resultStrring){
                $resultStrring .= $this->textLine($elementName, 1);
                foreach($elementList as $element){
                    $resultStrring .= $this->textLine($elementName, 2);
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