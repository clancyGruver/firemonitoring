<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\MonitoringObject as MO;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Facades\Storage;

class ObjectMediafile extends Model
{
    use SoftDeletes;
    protected $table = 'objects_mediafiles';
    protected $primaryKey = 'id';
    protected $fillable = [
        'object_id',
        'filename',
        'description',
    ];

    protected $appends = ['path'];

    public function object(){
        return $this->hasOne('App\MonitoringObject', 'object_id', 'id');
    }

    public function getPathAttribute(){
        return $this->url = Storage::url('objectMedia/'.$this->object_id.'/'.$this->filename);
    }
}
