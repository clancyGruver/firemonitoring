<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\reglament_works as RW;
use App\device_reglament as DR;
use App\Sensor;
use App\Wire;

class WireSensor extends Model
{
    use SoftDeletes;
	protected $table = 'wire_sensor';
    protected $primaryKey = 'id';
    protected $fillable = [
		'wire_id',
		'sensor_id',
		'created_user_id',
		'name',
		'floor',
		'cabinet_name',
		'SP5_valid',
		'is_good',
		'comment',
        'bti_files_id',
        'lng',
        'lat',
	];

    protected $appends = ['icon'];

	public function getIconAttribute(){
		return Sensor::withTrashed()->find($this->sensor_id)->icon;
	}

	public function wire(){
		return $this->belongsTo('App\Wire','wire_id','id')->with('device');
	}
    public static function boot() {
        parent::boot();

        static::deleting(function($od) {
            RW::where([
            	['device_id', '=' ,$od->id],
            	['tbl_name', '=' ,'App/Sensor'],
            ])->delete();
        });

        static::created(function($sensor) {
            $data = [];
            $keys = DR::where([
                ['device_id',$sensor->sensor_id],
                ['tbl_name','App\Sensor'],
            ])->get()->modelKeys();
            $curDate = date("Y-m-d H:i:s");
            foreach ($keys as $v) {
                $data[] = [
                    'reglament_id'         => $v,
                    'device_id'            => $sensor->id,
                    'planned_reglament_at' => $curDate,
                    'created_user_id'      => $sensor->created_user_id,
                    'tbl_name'             => 'App/Sensor',
                ];
            }
            RW::insert($data);
        });
    }
}