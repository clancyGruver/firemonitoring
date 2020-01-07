<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Storage;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\device_limitations;

class Sensor extends Model
{
    use SoftDeletes;
    use Reglaments;

    protected $table = 'sensors';
    protected $primaryKey = 'id';
    protected $attributes = [
        'is_active' => true,
    ];
    protected $fillable = [
        'name',
        'is_automate',
        'power_supply',
        'is_address',
        'standalon_function',
        'standalon_smoke_is_radioisotop',
        'automate_attribute',
        'automate_reaction',
        'created_user_id',
        'instruction',
    ];

    protected $appends = ['icon', 'instrutionPath'];

    public function getInstrutionPathAttribute(){
        return Storage::url('instructions/sensors/'.$this->id.'/'.$this->instruction);
    }

    public function getIconAttribute(){
        $url = 'icons/sensors/';
        return [
            'good' => Storage::url(  $url . 'auto_fire.png' ),
            'bad' => Storage::url(  $url . 'auto_fire_red.png' ),
            'sp5' => Storage::url(  $url . 'auto_fire_orange.png' ),
        ];
        if(!$this->is_automate)
            return [
                'good' => Storage::url($url . 'manual.png'),
                'bad' => Storage::url($url . 'manual_red.png'),
                'sp5' => Storage::url(  $url . 'manual_orange.png' ),
            ];
        else{
            $url .= 'auto_';
            return [
                'good' => Storage::url( $url . $this->automate_attribute . '.png'),
                'bad' => Storage::url( $url . $this->automate_attribute . '_red.png'),
                'sp5' => Storage::url(  $url . $this->automate_attribute . '_orange.png' ),
            ];
        }
    }


    public static function boot() {
        parent::boot();

        static::created(function($sensor) {
            $obj = new device_limitations();
            $obj->device_id = $sensor->id;
            $obj->text = 'Неисправность извещателя';
            $obj->created_user_id = $sensor->created_user_id;
            $obj->tbl_name = 'App\Sensor';
            $obj->save();
        });
    }

}
