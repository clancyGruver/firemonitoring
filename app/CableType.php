<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class CableType extends Model
{
    protected $table = "cable_types";
    protected $fillable = [
        'name',
    ];
}
