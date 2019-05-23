<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class DeviceClass extends Model
{
    
    protected $table = 'device_class';
    protected $primaryKey = 'id';
    protected $attributes = [
        'is_active' => true,
    ];
    protected $fillable = [
        'is_active',
        'name',
    ];

    public function devices(){
        return $this->hasMany('App\Devices', 'class_id', 'id');
    }

}
