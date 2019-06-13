<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\MonitoringObject as MO;

class ObjectMediafile extends Model
{
    protected $table = 'objects_mediafiles';
    protected $primaryKey = 'id';
    protected $fillable = [
        'object_id',
        'filename',
        'description',
    ];

    public function object(){
        return $this->hasOne('App\MonitoringObject', 'object_id', 'id');
    }
}
