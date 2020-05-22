<?php 
namespace App\Repositories;

use PhpOffice\PhpWord\TemplateProcessor;

class WordWriter{

    private $tempateFile = null;
    private $outputFile = null;

    public function __construct($template, $output){
        $this->tempateFile = $template;
        $this->outputFile = $output;
    }

}