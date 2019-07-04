<?php

namespace App;

use Illuminate\Support\Facades\Storage;
use Illuminate\Database\Eloquent\SoftDeletes;

class device_system_voice_alert extends Device
{
    protected $table = 'device_system_voice_alerts';

    protected $appends = ['icon'];

    public function get_instruction_path(){
    	return $this->url = Storage::url('instructions/sys_alert/'.$this->id.'/'.$this->instruction);
    }

	public function getIconAttribute(){
		/*if($this->)
		return $this->url = Storage::url('bti/'.$this->object_id.'/'.$this->name);*/
		return false;
	}
}
