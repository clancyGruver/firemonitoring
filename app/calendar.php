<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class calendar extends Model
{
    use SoftDeletes;
    protected $table="calendar";
    protected $fillable = [
        'admin_id',
        'technic_id',
        'object_id',
        'device_id',
        'work_type',
        'reglament_dev_type',
        'reglament_id',
        'comment',
        'planned_at'
    ];
}
