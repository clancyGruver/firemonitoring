<?php

namespace App;

use Illuminate\Support\Facades\Storage;
use Illuminate\Database\Eloquent\SoftDeletes;

class device_antenna extends Device
{
    use SoftDeletes;
    protected $table = 'device_antenna';

    protected $appends = ['icon','instrutionPath'];

    public function getInstrutionPathAttribute(){
        return Storage::url('instructions/antennas/'.$this->id.'/'.$this->instruction);
    }

    public function getIconAttribute(){
        return Storage::url('icons/antennas/antenna.png');
    }
    //
}
