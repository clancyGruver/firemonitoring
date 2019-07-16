<?php

namespace App;

use Illuminate\Support\Facades\Storage;

class device_system_voice_alerts_dev extends Device
{
    protected $table = 'device_system_voice_alerts_devs';

    protected $fillable = [
        'device_system_voice_alerts_id',
        'device_alerts_id',
        'created_user_id',
        'bti_files_id',
        'lng',
        'lat',
    ];

    public function alertDevice(){
    	return $this->hasOne('App\device_alert','id','device_alerts_id');
    }
}
