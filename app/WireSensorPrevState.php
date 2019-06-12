<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class WireSensorPrevState extends Model
{
	protected $table = 'wire_sensor_previous_state';
    protected $primaryKey = 'id';
    protected $fillable = [
		'wire_sensor_id',
		'wire_id',
		'sensor_id',
		'created_user_id',
		'name',
		'floor',
		'cabinet_name',
		'SP5_valid',
		'is_good',
		'is_active',
	];
}