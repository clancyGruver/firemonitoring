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

    protected $appends = ['type'];

    public function devicable(){
        return $this->morphTo(
            null,
            'tbl_name',
            'device_id'
        );
    }

    public function getTypeAttribute(){
        $types = [
            'App\device_antenna'            => 'Антенна',
            'App\device_rspi'               => 'Системы передачи извещений о пожаре',
            'App\device_aps'                => 'Охранно-пожарная сигнализация',
            'App\device_alert'              => 'Оповещатели',
            'App\device_system_voice_alert' => 'Система речевого оповещения',
        ];
        return $types[$this->tbl_name];
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
