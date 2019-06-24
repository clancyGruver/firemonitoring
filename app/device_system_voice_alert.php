<?php

namespace App;

class device_system_voice_alert extends Device
{
    protected $table = 'device_system_voice_alerts';

    public function get_instruction_path(){
    	return $this->url = Storage::url('instructions/sys_alert/'.$this->id.'/'.$this->instruction);
    }
}
