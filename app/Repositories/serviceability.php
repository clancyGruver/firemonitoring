<?php
namespace App\Repositories;

use App\MonitoringObject as MO;
use App\Object_Device as OD;
use App\object_device_reglament_limitations as ODRL;
;

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

    private function checkForDefects($devices){
        $dateMinusTenYears = new \DateTime();
        $devices->each(function($device) use ($dateMinusTenYears){
            $device->defects = collect([]);
            //Проверка, что обородувание установлено более 10 лет назад
             if(!is_null($device->setup_year) && $device->setup_year >= $dateMinusTenYears->format('Y')){
                $device->defects->put('tenYearsAgoSetup',true);
             }
            //проверка кабеля на огнестойкость и исправность извещателей
            if($device->tbl_name == $this->tables['aps']){ // если оборудование ОПС
                //проверка кабеля на огнестойкость
                $unsafeWires = $device->wires->filter(function($wire){
                    return $wire->type == 'unsafe';
                });
                $device->defects->put('unsafeWires',$unsafeWires);
                //проверка исправности извещателей
                $device->defects->put('badSensors',collect([]));
                $device->defects->put('badSetup',collect([]));
                $device->wires->each(function($wire) use ($device){
                    $badSensorsCount= $wire->sensors->filter(function ($sensor) {
                        return $sensor->is_good == 0;
                    })->count();
                    $badSetupCount= $wire->sensors->filter(function ($sensor) {
                        return $sensor->SP5_valid == 0;
                    })->count();
                    $device->defects['badSetup']->put($wire->description, $badSetupCount); 
                    $device->defects['badSensors']->put($wire->description, $badSensorsCount); 
                });
            }
            //Прочие дефекты
            if(!$device->is_good){//если оборудование неисправно
                //Проверка на критичность
                $allLimittions = ODRL::where('object_device_id', $device->id)->get();
                $critical = $allLimittions->filter(function ($distinctLimitation) {
                    return $distinctLimitation->additional_limitation_critical == 1;
                });
                $nonCritical = $allLimittions->diff($critical);
                $device->defects->put('critical', $critical);
                $device->defects->put('nonCritical', $nonCritical);
            }
        });
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

    public function defects(){
        //$device->is_good === 0;
        $this->checkForDefects($this->rspiDevices);
        $this->checkForDefects($this->devices);
    }

    public function printDevices(){
        $this->devices->each(function ($device) {
            print_r("<p>".$device->devicable->name."</p>");
            $device->defects->each(function ($defect, $key) {
                switch($key){
                    case 'unsafeWires': 
                        $this->printUnsafeWires($defect);
                        break;
                    case 'critical':
                        $this->printCriticalDefects($defect);
                        break;
                    case 'nonCritical':
                        $this->printNonCriticalDefects($defect);
                        break;
                    case 'badSensors':
                        $this->printBadSensors($defect);
                        break;
                    case 'badSetup':
                        $this->printBadSetup($defect);
                        break;
                        
                    default: print_r("<p>".$key."</p>"); break;
                }
            });
        });
    }

    private function printUnsafeWires($defect){
        print_r("<p>Пожароопасный кабель</p>");
        print("<ul>");
        $defect->each(function ($wire){
            print("<li>");
            print($wire->description);
            print("</li>");
        });
        print("</ul>");
    }

    private function printCriticalDefects($defect){
        print_r("<p>Критичные недостатки</p>");
        print("<ul>");
        $defect->each(function ($criticalDefect){
            print("<li>");
            print($criticalDefect->additional_limitation);
            print("</li>");
        });
        print("</ul>");
    }

    private function printNonCriticalDefects($defect){
        print_r("<p>Критичные недостатки</p>");
        print("<ul>");
        $defect->each(function ($nonCriticalDefect){
            print("<li>");
            print($nonCriticalDefect->additional_limitation);
            print("</li>");
        });
        print("</ul>");
    }

    private function printBadSensors($defect){
        print_r("<p>Неисправные извещатели</p>");
        print("<ul>");
        $defect->each(function ($sensorCount, $wireName){
            if($sensorCount > 0){
                print("<li>");
                print("Шлейф: " . $wireName . " - ");
                print($sensorCount . " шт.");
                print("</li>");
            }
        });
        print("</ul>");
    }

    private function printBadSetup($defect){
        print_r("<p>Извещатели, установленные с нарушением СП-5</p>");
        print("<ul>");
        $defect->each(function ($sensorCount, $wireName){
            if($sensorCount > 0){
                print("<li>");
                print("Шлейф: " . $wireName . " - ");
                print($sensorCount . " шт.");
                print("</li>");
            }
        });
        print("</ul>");
    }

}