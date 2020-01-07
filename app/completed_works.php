<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class completed_works extends Model
{
    //
    use SoftDeletes;
    protected $table="completed_works";
    protected $fillable = [
        'object_id',
        'object_device_id',
        'user_id',
        'work_type',
    ];
    public const work_types = [
        'repair' => 0,
        'setup' => 1,
        'remove' => 2,
        'reglament' => 3

    ];
}
