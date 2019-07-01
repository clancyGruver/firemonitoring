<?php

namespace App;
use Illuminate\Support\Facades\Storage;

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

    protected $appends = ['icon'];

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

    public function getIconAttribute(){
        return Storage::url('icons/alerts/'.$this->type.'.png');
    }
}
