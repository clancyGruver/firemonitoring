<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Object_Device;
use App\repairQueue;
use Illuminate\Support\Facades\DB;


class object_device_reglament_limitations extends Model
{
    use SoftDeletes;
    protected $table = 'object_device_reglament_limitations';
    protected $primaryKey = 'id';
    protected $fillable = [
        'object_device_id',
        'ODR_id',
        'DL_id',
        'created_user_id',
        'additional_limitation',
    ];


    public static function boot() {
        parent::boot();

        static::restoring(function($od) {
            $prevVal = $od->original;
            $curVal = $od->attributes;
            if($prevVal['additional_limitation'] || $curVal['additional_limitation']){
                $repairQueue = repairQueue::where('device_id', $od->object_device_id)
                                            ->whereNull('done_at')
                                            ->whereNotNull('additional_limitation')
                                            ->first();
                if($repairQueue){
                    if($repairQueue->additional_limitation != $curVal['additional_limitation']){
                        $repairQueue->done_at = date('Y-m-d H:i:s');
                        $repairQueue->repairer_id = $od->created_user_id;
                        $repairQueue->save();
                    }
                    else{
                        return;
                    }
                }

                $object = Object_Device::find($od->object_device_id);
                $data = [
                    'type' => 'device',
                    'object_id' => $object->object_id,
                    'device_id' => $od->object_device_id,
                    'finder_id' => $od->created_user_id,
                    'additional_limitation' => $curVal['additional_limitation'],
                ];
                $repairQueue = new repairQueue($data);
                $repairQueue->save();
            }
        });
        static::deleting(function($od) {
            $prevVal = $od->original;
            if(isset($prevVal['additional_limitation']) && $prevVal['additional_limitation']){
                $repairQueue = repairQueue::where('device_id', $od->object_device_id)
                                            ->whereNull('done_at')
                                            ->whereNotNull('additional_limitation')
                                            ->first();
                if($repairQueue){
                    $repairQueue->done_at = date('Y-m-d H:i:s');
                    $repairQueue->repairer_id = $od->created_user_id;
                    $repairQueue->save();
                }
            }
        });

        static::created(function($od) {
            $object = Object_Device::find($od->object_device_id);

            $data = [
                'type' => 'device',
                'object_id' => $object->object_id,
                'device_id' => $od->object_device_id,
                'finder_id' => $od->created_user_id,
            ];
            if($od->additional_limitation){
                $data['additional_limitation'] = $od->additional_limitation;
            }
            else{
                $data['limitation_id'] = $od->DL_id;
            }
            $repairQueue = repairQueue::where($data)->whereNull('done_at')->firstOrCreate($data);
        });
        static::deleted(function($od) {
            $object = Object_Device::find($od->object_device_id);
            $whereArr =[
                ['object_id', '=', $object->object_id],
                ['device_id', '=', $od->object_device_id],
                ['limitation_id','=',$od->DL_id],
            ];
            $repairQueue = repairQueue::where($whereArr)->whereNull('done_at')->first();
            if($repairQueue){
                $repairQueue->done_at = date('Y-m-d H:i:s');
                $repairQueue->repairer_id = $od->created_user_id;
                $repairQueue->save();
            }
        });
        static::restored(function($od) {
            if($od->additional_limitation) return;
            $object = Object_Device::find($od->object_device_id);

            $data = [
                'type' => 'device',
                'object_id' => $object->object_id,
                'device_id' => $od->object_device_id,
                'limitation_id' => $od->DL_id,
            ];
            $whereArr = [];
            foreach ($data as $key => $value) {
                $whereArr[] = [$key, '=', $value];
            }
            $data['finder_id'] = $od->created_user_id;
            repairQueue::where($whereArr)->whereNull('done_at')->firstOrCreate($data);
        });
    }
}
