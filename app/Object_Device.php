<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Object_Device extends Model
{
    use SoftDeletes;
    protected $table = 'object_devices';
    protected $primaryKey = 'id';
    protected $fillable = [
        'created_user_id',
        'tbl_name',
        'object_id',
        'device_id',
    ];

    public function devicable(){
        return $this->morphTo(
            null,
            'tbl_name',
            'device_id'
        );
    }

    public function devices(){
        return $this->hasMany('', 'id', 'device_id');
    }

    public function device(){
        return $this->hasOne('App\device_aps', 'id', 'device_id');
    }

    public function wires(){
        return $this->hasMany('App\Wire', 'object_device_id', 'id')->with('sensors');
    }
}
