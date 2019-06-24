<?php

namespace App;

class device_alert extends Device
{
    protected $table = 'device_alerts';
    protected $fillable = [
        'type',
        'power',
        'name',
        'instruction',
        'created_user_id',
    ];

    public function type_name(){
    	$arr = [
    		'sound'=>'Звуковой',
    		'voice'=>'Речевой',
    		'light'=>'Световой'
    	];
    	return $arr[$this->type];
    }

    public function get_instruction_path(){
    	return $this->url = Storage::url('instructions/alert/'.$this->id.'/'.$this->instruction);
    }
}
