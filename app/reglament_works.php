<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use App\device_reglament as DR;

class reglament_works extends Model
{
    protected $table = "reglament_works";
    protected $fillable = [
        "done_at",
        'planned_reglament_at',
    ];

    public function object() {
        return $this->hasOne('App\Object_Device','id','device_id');
    }

    public function getPlannedReglamentAtAttribute($date)
    {
        return date('d-m-Y', strtotime($date));
    }

    public function getDoneAtAttribute($date)
    {
        return $date != null ? date('d-m-Y', strtotime($date)) : null;
    }

    public static function boot() {
        parent::boot();

        static::updating(function($reglament) {
            $data = [];
            $dr = DR::find($reglament->reglament_id)->toArray();
            $nextDate = new \DateTime();
            $curDate = date("Y-m-d H:i:s");
			$formats = [
				'D' => 'day',
				'Y' => 'year',
				'M' => 'month',
				'W' => 'week',
			];
            $interval = null;
            foreach ($formats as $k => $per) {
            	if(!is_null($dr[$per])){
                    $interval = new \DateInterval('P'.$dr[$per].$k);
                    $nextDate->add($interval);
                }
            }
            $reglament->planned_reglament_at = $nextDate->format('Y-m-d H:i:s');
        });
    }
}
