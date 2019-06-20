<?php

namespace App;

class device_aps extends Device
{
    protected $fillable = [
        'name',
        'wires_count',
        'instruction',
        'created_user_id',
    ];
}
