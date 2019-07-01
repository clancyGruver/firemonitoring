<?php

namespace App;

class device_antenna extends Device
{
    protected $table = 'device_antenna';

    protected $appends = ['icon'];

    public function getIconAttribute(){
        return Storage::url('icons/antennas/antenna.png');
    }
    //
}
