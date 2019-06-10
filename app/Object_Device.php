<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Object_Device extends Model
{
    protected $table = 'object_devices';
    protected $primaryKey = 'id';
    protected $attributes = [
        'is_active' => true,
    ];
    protected $fillable = [
        'is_active',
        'created_user_id',
        'object_id',
        'device_id',
    ];


    public function devices(){
        return $this->hasMany('App\Device', 'id', 'device_id');
    }

    public function device(){
        return $this->hasOne('App\Device', 'id', 'device_id');
    }

    public function wires(){
        return $this->hasMany('App\Wire', 'object_device_id', 'id')->with('sensors');   
    }
}
