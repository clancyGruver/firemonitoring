<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Facades\Storage;


class bti_files extends Model
{
    use SoftDeletes;
    protected $table="bti_files";
    protected $primaryKey = 'id';
    protected $fillable = [
        'name',
        'object_id',
        'created_user_id',
    ];

    public function object()
	{
		return $this->belongsTo('App\MonitoringObject');
	}

	public function path(){
		return $this->url = Storage::url('bti/'.$this->object_id.'/'.$this->name);
	}
}
