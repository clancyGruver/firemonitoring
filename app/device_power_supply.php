<?php

namespace App;

use Illuminate\Support\Facades\Storage;
use Illuminate\Database\Eloquent\SoftDeletes;

class device_power_supply extends Device
{
    use SoftDeletes;

    protected $fillable = [
        'name',
		'accumulator_count',
		'battery_capacity',
		'output_voltage',
		'instruction',
		'created_user_id',
    ];

    protected $appends = ['instrutionPath'];

    public function get_instruction_path(){
    	return $this->url = Storage::url('instructions/power_supply/'.$this->id.'/'.$this->instruction);
    }

    public function getInstrutionPathAttribute(){
    	return Storage::url('instructions/power_supply/'.$this->id.'/'.$this->instruction);
    }
}
