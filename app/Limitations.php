<?php

namespace App;

trait Limitations{

    public function limitations()
    {
        if(isset($this->model_name))
            return $this->morphMany('App\device_limitations', 'device', 'model_name');
        else
            return $this->morphMany('App\device_limitations', 'device', 'tbl_name');
    }
}
