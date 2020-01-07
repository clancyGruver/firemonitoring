<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\Device;

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
        return $this->hasMany('App\Device', 'class_id', 'id')->where('is_active',1);
    }

}
