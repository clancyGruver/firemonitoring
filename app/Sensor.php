<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Sensor extends Model
{
    protected $table = 'sensors';
    protected $primaryKey = 'id';
    protected $attributes = [
        'is_active' => true,
    ];
    protected $fillable = [
        'is_active',
        'name',
        'is_automate',
        'power_supply',
        'is_address',
        'standalon_function',
        'standalon_smoke_is_radioisotop',
        'automate_attribute',
        'automate_reaction',
        'created_user_id',
    ];
}
