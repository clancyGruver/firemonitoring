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
        return [
            'good' => Storage::url('icons/antennas/antenna_green.png'),
            'bad' => Storage::url('icons/antennas/antenna_red.png'),
        ];
    }
    //
}
