<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\reglament_works as RW;
use App\device_reglament as DR;
use App\Wire;
use Illuminate\Database\Eloquent\SoftDeletes;

class Object_Device extends Model
{
    use SoftDeletes;
    protected $table = 'object_devices';
    protected $primaryKey = 'id';
    protected $fillable = [
        'created_user_id',
        'tbl_name',
        'object_id',
        'device_id',
        'parent_id',
        'bti_files_id',
        'setup_year',
        'is_good',
        'lng',
        'lat',
    ];

    protected $appends = ['type','params'];

    public function getParamsAttribute(){
        if($this->tbl_name == 'App\device_antenna' || $this->tbl_name == 'App\device_rspi'){
            $type = $this->tbl_name.'_params'::class;
            if(class_exists($type))
                return $this->hasOne($type, 'device_id', 'id')->first();
        }
    }

    public function devicable(){
        return $this->morphTo(
            null,
            'tbl_name',
            'device_id'
        );
    }

    public function getTypeAttribute(){
        $types = [
            'App\device_antenna'            => 'Антенна',
            'App\device_rspi'               => 'Системы передачи извещений о пожаре',
            'App\device_aps'                => 'Охранно-пожарная сигнализация',
            'App\device_alert'              => 'Оповещатели',
            'App\device_system_voice_alert' => 'Система речевого оповещения',
            'App\Sensor'                    => 'Извещатель',
            'App\device_power_supply'       => 'Блок питания',
        ];
        return $types[$this->tbl_name];
    }

    public function devices(){
        return $this->hasMany('', 'id', 'device_id');
    }

    public function device(){
        return $this->hasOne('App\device_aps', 'id', 'device_id');
    }

    public function wires(){
        return $this->hasMany('App\Wire', 'object_device_id', 'id')->with('sensors');
    }

    public function alerts(){
        return $this->hasMany('App\Object_Device', 'parent_id', 'id')->with('devicable');
    }

    public function object(){
        return $this->belongsTo('App\MonitoringObject', 'object_id', 'id');
    }
    public static function boot() {
        parent::boot();

        static::deleting(function($od) {
            if($od->tbl_name == 'App\device_aps'){
                Wire::where('object_device_id',$od->id)->delete();
            }
            RW::where('device_id',$od->id)->delete();
        });

        static::created(function($od) {
            $data = [];
            $keys = DR::where([
                ['device_id',$od->device_id],
                ['tbl_name',$od->tbl_name],
            ])->get()->modelKeys();
            $curDate = date("Y-m-d H:i:s");
            foreach ($keys as $v) {
                $data[] = [
                    'reglament_id' => $v,
                    'device_id'    => $od->id,
                    'planned_reglament_at' => $curDate,
                    'created_user_id' => $od->created_user_id,
                ];
            }
            RW::insert($data);
        });
    }
}
