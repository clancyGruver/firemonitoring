<?php
namespace App\Repositories;

use App\MonitoringObject as MO;
use App\Object_Device as OD;

class Serviceability{
    private $tables = [
        'antennas' => 'App\device_antenna',
        'aps' => 'App\device_aps',
        'alerts' => 'App\device_alerts',
        'ibp' => 'App\device_power_supplies',
        'rspi' => 'App\device_rspi',
        'sva' => 'App\device_system_voice_alerts',
    ];
    private $rspi_tables = [
        'App\device_rspi',
        'App\device_antenna'
    ];
    private $device_tables = [
        'App\device_aps',
        'App\device_alerts',
        'App\device_power_supplies',
        'App\device_system_voice_alerts'
    ];
    private $object;
    private $allDevices;
    private $rspiDevices;
    private $devices;

    public function __construct($object_id){
        $this->object = MO::find($object_id);
        $this->allDevices = OD::where('object_id', $object_id)->get();
        $this->getDevices();
        $this->getRspiDevices();
    }

    public function tenYearsOldDevices(){
        $dateMinusTenYears = new \DateTime();
        $dateMinusTenYears = $dateMinusTenYears->sub(new \DateInterval('P10Y'));
        $rspis = $this->rspiDevices->filter( function($device) use ($dateMinusTenYears) {
            return !is_null($device->setup_year) && $device->setup_year < $dateMinusTenYears->format('Y');
        } );
        $devices = $this->devices->filter( function($device) use ($dateMinusTenYears) {
            return !is_null($device->setup_year) && $device->setup_year < $dateMinusTenYears->format('Y');
        } );
        return [
            'rspi' => $rspis,
            'devices' => $devices
        ];
    }

    public function defects(){
        $device->is_good === 0;
        $rspis = $this->rspiDevices->filter( function($device) {
            return !is_null($device->setup_year) && $device->setup_year < $dateMinusTenYears->format('Y');
        } );
        $devices = $this->devices->filter( function($device){
            return !is_null($device->setup_year) && $device->setup_year < $dateMinusTenYears->format('Y');
        } );
        return [
            'rspi' => $rspis,
            'devices' => $devices
        ];
    }

    public function criticalDefects(){
        
    }

    private function getRspiDevices(){
        $this->rspiDevices = $this->allDevices->filter( function($device) {
            return in_array($device->tbl_name, $this->rspi_tables);
        } );
    }

    private function getDevices(){
        $this->devices = $this->allDevices->filter( function($device) {
            return in_array($device->tbl_name, $this->device_tables);
        } );
    }

}