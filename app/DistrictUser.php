<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\MonitoringObject;

class DistrictUser extends Model
{
    use SoftDeletes;
    
    protected $table = 'districtsusers';
    protected $primaryKey = 'id';

    public function district(){
        return $this->hasOne('App\District','id','district_id');
    }

    public function user(){
        return $this->hasOne('App\User','id','user_id');
    }
}
