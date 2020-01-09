<?php

namespace App;

trait Reglaments{
    public function reglaments(){
        return $this->morphMany('App\device_reglament', 'device', 'tbl_name')->orderBy('id');
    }
}
