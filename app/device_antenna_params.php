<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Storage;
use Illuminate\Database\Eloquent\SoftDeletes;

class device_antenna_params extends Model
{
    protected $table = 'device_antenna_params';

    protected $fillable = [
        'device_antenna_id',
        'setup_place',
        'mast_isset',
        'mast_height',
        'cable_type',
        'created_user_id',
    ];
}
