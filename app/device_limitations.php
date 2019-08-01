<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class device_limitations extends Model
{
    protected $table = 'device_limitations';

    protected $fillable = [
        'device_id',
        'text',
        'created_user_id',
    ];
}
