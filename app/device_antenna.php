<?php

namespace App;

use Illuminate\Support\Facades\Storage;
use Illuminate\Database\Eloquent\SoftDeletes;

class device_antenna extends Device
{
    protected $table = 'device_antenna';

    protected $appends = ['icon'];

    public function getIconAttribute(){
        return Storage::url('icons/antennas/antenna.png');
    }
    //
}
