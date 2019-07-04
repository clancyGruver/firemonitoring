<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class WireSensor extends Model
{
    use SoftDeletes;
	protected $table = 'wire_sensor';
    protected $primaryKey = 'id';
    protected $fillable = [
		'wire_id',
		'sensor_id',
		'created_user_id',
		'name',
		'floor',
		'cabinet_name',
		'SP5_valid',
		'is_good',
		'comment',
        'bti_files_id',
        'lng',
        'lat',
	];
}