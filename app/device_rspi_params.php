<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class device_rspi_params extends Model
{
    protected $table = 'device_rspi_params';

    protected $guarded = ['id'];

	protected $fillable = [
		'setup_place',
		'battery',
		'power_supply',
		'capacity',
		'coupling',
		'created_user_id',
		'device_id',
	];

}
