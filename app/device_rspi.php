<?php

namespace App;

use Illuminate\Support\Facades\Storage;

class device_rspi extends Device
{
    protected $table = 'device_rspi';

    public function get_instruction_path(){
    	return $this->url = Storage::url('instructions/rspi/'.$this->id.'/'.$this->instruction);
    }
}
