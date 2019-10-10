<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class District extends Model
{
    use SoftDeletes;
    
    protected $fillable = [
        'name',
    ];

    public function objects(){
        return $this->hasMany(DistrictObject::class)->with('object');
    }
    public function users(){
        return $this->hasMany(DistrictUser::class)->with('user');
    }
}
