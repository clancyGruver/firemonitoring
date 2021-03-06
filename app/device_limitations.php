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
        'text',
        'isCritical',
        'created_user_id',
        'tbl_name'
    ];

    public function limitable()
    {
        return $this->morphTo();
    }
}
