<?php

namespace App;

use Illuminate\Support\Facades\Storage;
use Illuminate\Database\Eloquent\SoftDeletes;

class device_alert extends Device
{
    use SoftDeletes;
    
    protected $table = 'device_alerts';
    protected $fillable = [
        'type',
        'power',
        'name',
        'instruction',
        'created_user_id',
    ];

    protected $appends = ['icon','instrutionPath'];

    public function getInstrutionPathAttribute(){
        return Storage::url('instructions/alerts/'.$this->id.'/'.$this->instruction);
    }

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
        return [
            'good' => Storage::url('icons/alerts/'.$this->type.'_green.png'),
            'bad' => Storage::url('icons/alerts/'.$this->type.'_red.png'),
            'sp5' => Storage::url('icons/alerts/'.$this->type.'_orange.png'),
        ];
    }
}
