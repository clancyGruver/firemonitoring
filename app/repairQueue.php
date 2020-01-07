<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class repairQueue extends Model
{
    use SoftDeletes;
    protected $table = 'object_repair_queue';

    protected $fillable = [
    	'object_id',
    	'device_id',
    	'type',
    	'technik_comment',
    	'finder_id',
    	'repairer_id',
    	'limitation_id',
    	'additional_limitation',
    	'done_at'
    ];
}
