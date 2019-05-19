<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class Raion extends Model
{
    protected $table = 'raions';
    protected $primaryKey = 'id';
    protected $attributes = [
        'is_active' => true,
    ];
    protected $fillable = ['is_active','name','lng','lat'];
}
