<?php

namespace App;

trait Limitations{
    public function limitations()
    {
		return $this->morphMany('App\device_limitations', 'device', 'tbl_name');
    }

}
