<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Raion extends Model
{
    use SoftDeletes;
    
    protected $table = 'raions';
    protected $primaryKey = 'id';
    protected $attributes = [
        'is_active' => true,
    ];
    protected $fillable = ['is_active','name','lng','lat'];
}
