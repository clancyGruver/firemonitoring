<?php

namespace App;

use Illuminate\Support\Facades\Storage;
use Illuminate\Database\Eloquent\SoftDeletes;

class device_rspi extends Device
{
    use SoftDeletes;

    protected $table = 'device_rspi';
    protected $appends = ['instrutionPath'];

    public function getInstrutionPathAttribute(){
        return Storage::url('instructions/rspi/'.$this->id.'/'.$this->instruction);
    }

    public function get_instruction_path(){
    	return $this->url = Storage::url('instructions/rspi/'.$this->id.'/'.$this->instruction);
    }
}
