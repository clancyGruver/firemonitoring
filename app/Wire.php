<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Wire extends Model
{
    protected $table = 'wires';
    protected $primaryKey = 'id';
    protected $attributes = [
        'is_active' => true,
    ];
    protected $fillable = [
        'is_active',
        'object_device_id',
        'created_user_id',
        'is_good',
        'description',
        'sertificate',
        'type'
    ];

    public function sensors(){
        return $this->hasMany('App\WireSensor', 'wire_id', 'id');
    }
}
