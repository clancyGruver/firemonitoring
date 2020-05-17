<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class WorkType extends Model
{
    use SoftDeletes;
    protected $table = 'work_type';
    protected $primaryKey = 'id';
    protected $fillable = [
        'object_id',
        'object_device_id',
        'user_id',
        'tbl_name',
        'created_at',
        'updated_at',
        'deleted_at',
        'work_type'
    ];

    public const work_types = [
        'repair',
        'setup',
        'delete',
        'reglament',
        'replacement',
    ];
}
