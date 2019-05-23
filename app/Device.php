<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Storage;


class Device extends Model
{
    
    protected $table = 'devices';
    protected $primaryKey = 'id';
    protected $attributes = [
        'is_active' => true,
    ];
    protected $fillable = [
        'is_active',
        'name',
        'wires_count',
        'instruction',
        'created_user_id',
        'class_id'
    ];


    public function class(){
        return $this->hasOne('App\DeviceClass', 'id', 'class_id');
    }
}
