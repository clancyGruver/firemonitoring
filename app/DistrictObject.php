<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\MonitoringObject;

class DistrictObject extends Model
{
    use SoftDeletes;
    
    protected $table = 'districtsobjects';
    protected $primaryKey = 'id';
    protected $fillable = [
		'district_id',
    	'object_id',
    ];

    public function object(){
        return $this->hasOne('App\MonitoringObject','id','object_id');
    }

    public function district(){
        return $this->hasOne('App\District','id','district_id');
    }
}
