<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Storage;
use Illuminate\Database\Eloquent\SoftDeletes;

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

    protected $appends = ['icon'];

    public function getIconAttribute(){
        return Storage::url(  'icons/sensors/auto_fire.png' );
        $url = 'icons/sensors/';
        if(!$this->is_automate)
            return Storage::url($url . 'manual.png');
        else{
            $url .= 'auto_';
            return Storage::url( url . $this->automate_attribute . '.png');
        }
    }

}
