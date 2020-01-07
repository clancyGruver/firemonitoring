<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use PhpOffice\PhpWord\TemplateProcessor;

class WordController extends Controller
{
    public function serviceabilityAct($object_id, Request $request){
        $file = '../storage/word_templates/serviceabilityAct.docx';
        $director = 'Иванов Иван Иванович';
        $technick = 'Петров Петр Петрович';
        $object_name = 'МОУ СОШ №1';
        $object_address = 'с. Аргаяш, ул. Фрунзе, 12';
        $defects = 'Без недостатков';
        $comment = '';
        $date = new \DateTime();

        $templateProcessor = new TemplateProcessor($file);

        $templateProcessor->setValues([
            'year'           => $date->format('Y'),
            'director_fio'   => $director,
            'technick_fio'   => $technick,
            'object_name'    => $object_name,
            'object_address' => $object_address,
            'defects'        => $defects,
            'comment'        => $comment,
        ]);

        $templateProcessor->saveAs(public_path('Акт исправности.docx'));

        return response()->download(public_path('Акт исправности.docx'));
    }
}
