<?php

namespace App;

use Illuminate\Support\Facades\Storage;
use Illuminate\Database\Eloquent\SoftDeletes;

class device_aps extends Device
{
    use SoftDeletes;
    
    protected $fillable = [
        'name',
        'wires_count',
        'instruction',
        'created_user_id',
    ];
    protected $appends = ['instrutionPath'];

    public function get_instruction_path(){
    	return $this->url = Storage::url('instructions/aps/'.$this->id.'/'.$this->instruction);
    }

    public function getInstrutionPathAttribute(){
    	return Storage::url('instructions/aps/'.$this->id.'/'.$this->instruction);
    }
}
