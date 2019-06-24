<?php

namespace App;

class device_aps extends Device
{
    protected $fillable = [
        'name',
        'wires_count',
        'instruction',
        'created_user_id',
    ];

    public function get_instruction_path(){
    	return $this->url = Storage::url('instructions/ops/'.$this->id.'/'.$this->instruction);
    }
}
