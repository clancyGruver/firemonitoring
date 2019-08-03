<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class device_limitations extends Model
{
    use SoftDeletes;
    protected $table = 'device_limitations';

    protected $fillable = [
        'device_id',
        'table',
        'text',
        'created_user_id',
    ];

    public function limitable()
    {
        return $this->morphTo();
    }
}
