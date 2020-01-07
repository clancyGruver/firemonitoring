<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class device_reglament_element extends Model
{
    use SoftDeletes;
    protected $table = 'device_reglament_element';

    protected $fillable = [
        'text',
        'created_user_id',
        'device_reglament_id',
    ];
}
