<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Wire extends Model
{
    use SoftDeletes;
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

    public function device(){
        return $this->belongsTo('App\Object_Device', 'object_device_id', 'id')->with('object');
    }

    public static function boot() {
        parent::boot();

        static::deleting(function($wire) {
            foreach ($wire->sensors as $sensor) {
                $sensor->delete();
            }
        });
    }
}
