<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\reglament_works as RW;
use App\Object_Device as OD;
use Illuminate\Database\Eloquent\SoftDeletes;

class device_reglament extends Model
{
    use SoftDeletes;
    protected $table = 'device_reglament';
    protected $with = ['elements'];

    protected $fillable = [
        'name',
        'day',
        'week',
        'month',
        'year',
        'created_user_id',
        'device_id',
        'tbl_name',
    ];

    public function reglamentable(){
        return $this->morphTo();
    }

    public function work($id){
        return $this->hasOne('App\reglament_works','reglament_id','id')->where('device_id',$id);
    }

    public function elements(){
        return $this->hasMany('App\device_reglament_element','device_reglament_id','id');
    }

    public static function boot() {
        parent::boot();

        static::deleting(function($reglament) {
            RW::where('reglament_id',$reglament->id)->delete();
            $reglament->elements()->delete();
        });

        static::created(function($reglament) {
            $data = [];
            $keys = OD::where([
                ['device_id',$reglament->device_id],
                ['tbl_name',$reglament->tbl_name],
            ])->get()->modelKeys();
            $curDate = date("Y-m-d H:i:s");
            foreach ($keys as $v) {
                $data[] = [
                    'reglament_id'         => $reglament->id,
                    'device_id'            => $v,
                    'planned_reglament_at' => $curDate,
                    'created_user_id'      => $reglament->created_user_id,
                ];
            }
            RW::insert($data);
        });
    }
}
