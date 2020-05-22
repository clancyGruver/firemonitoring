<?php 
namespace App\Repositories;

use PhpOffice\PhpWord\TemplateProcessor;
use Illuminate\Support\Facades\Auth;

class WordWriter{

    private $templateFile = null;
    private $outputFile = null;

    public function __construct($template, $output){
        $this->templateFile = $template;
        $this->outputFile = $output;
    }

    public function serviceReportAct(\App\Repositories\Serviceability $serv){
        $technick = Auth::user()->name;
        
        $templateProcessor = new TemplateProcessor($this->templateFile);

        dd($serv->getDeviceList());

        $templateProcessor->setValues([
            'year'           => $date->format('Y'),
            'director_fio'   => $serv->getDirector(),
            'technick_fio'   => $technick,
            'object_name'    => $serv->getObjectName(),
            'object_address' => $serv->getAddress(),
            'defects'        => $defects,
        ]);
    }



}