<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class WireSensor extends Model
{
	protected $table = 'wire_sensor';
    protected $primaryKey = 'id';
    protected $attributes = [
        'is_active' => true,
    ];
    protected $fillable = [
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