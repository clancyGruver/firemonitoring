<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Storage;
use Illuminate\Database\Eloquent\SoftDeletes;

class Device extends Model
{
    use SoftDeletes;
	use Limitations;
    protected $primaryKey = 'id';
    protected $fillable = [
        'name',
        'instruction',
        'created_user_id',
    ];
}
