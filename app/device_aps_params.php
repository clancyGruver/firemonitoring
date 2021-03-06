<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class device_aps_params extends Model
{
    protected $table = 'device_aps_params';

    protected $guarded = ['id'];

	protected $fillable = [
		'created_user_id',
		'device_id',
		'accumulator_isset',
		'accumulator_count',
		'battery_capacity',
		'output_voltage',
	];
}
