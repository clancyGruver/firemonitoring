<?php
namespace App\Services;

use App\User;
use DateTime;
use Illuminate\Support\Facades\DB;
use App\MonitoringObject as MO;
use App\District;
use App\reglament_works;

class ReglamentPlanService {
	private $vocations = [];
	private $curDate;
	private $reglamentDate;
	private $planCalendar = [];
	private $districts = [];
	private $objects = [];
	private $technickWorkTime = 7 * 60; // 7 hours
	private $endDate;
	private $technicks = [];
	private $district;
	private $object;
	private $startDate;
	private $remains;

	function __construct() {
		$this->fillDistricts();
		$this->objects = MO::all();
		$this->fillVocations();
		$this->fillTechnicks();
		$this->remains = collect();
	}

	public function createYearPlan(string $startDate = null, string $endYear = null){
		$this->setStartDate($startDate);
		$this->setEndDate($endYear);
		$this->setCurDate($this->startDate);
		$this->nextDistrict();
		while(!is_null($this->district)){ // пока не закончились участки работ
			$technickCounter = 0;
			$technickLoopFlag = true;
			while($technickLoopFlag){
				$technickId = $this->district['technicks'][$technickCounter]->user_id;
				$timeLeft = $this->technickWorkTime; // Оставшееся рабочее время у техника

				$this->nextObjectInDistrict();
				while(!is_null($this->object)){ // пока имеются объекты
					$devices = $this->object->devices; // все оборудование на объекте
					
					foreach($devices as $device){ // Проходимся по всему оборудованию
						foreach($device->reglaments as $reglament){ // Получаем все регламенты на оборудование
							//dump([$reglament->duration, $timeLeft]);
							if($timeLeft - $reglament->duration > 0){ // Если время проведения регламента не превышает оставшееся рабочее время ехника
								$timeLeft -= $reglament->duration; // Из оставшегося рабочего времени вычесть продолжительность проведения регламента								
								$humanDate = $this->curDate->format('d.m.Y');
								if(!isset($this->planCalendar[$humanDate])){
									$this->planCalendar[$humanDate] = [];
								}									
								$this->planCalendar[$humanDate][] = [ // внести в план
									'district_id'      => $this->districtOject->district_id,
									'object_id'        => $this->object->id,
									'object_device_id' => $device->id,
									'reglament_id'     => $reglament->id,
									'tbl_name'         => $device->tbl_name,
									'technick_id'      => $technickId,
								];
							} else {
								//dd($this->object);
								$this->remains->push([
									$technickId => [
										$this->object->id => [
											'type'             => '',
											'reglament_id'     => $reglament->id,
											'object_device_id' => $device->id,
										]
									]
								]);
							}
						}
					}

					$this->nextObjectInDistrict();

					$technickCounterRestart = $technickCounter == $this->district['technickCount'] - 1;
					if($technickCounterRestart){
						$technickCounter = 0;
						$this->nextDay();
					} else {
						++$technickCounter;
					}
				}
				$technickLoopFlag = false;
			}
		
			$this->nextDistrict();
			$this->setCurDate($this->startDate); // устанавливаем начальную дату при смене участка
		}
		dd($this->remains);
		dd($this->planCalendar);

		if($this->objects->count() > 0){
			$this->nextObject();
		}
	}

	/**
	 * set current object from objects array
	 *
	 * @return void
	 */
	private function nextObject():void
	{
		if($this->objects->count() > 0){
			$this->object = $this->objects->pop();
		} else {
			$this->object = null;
		}
	}

	/**
	 * set current date as $date
	 *
	 * @param  DateTime $date
	 *
	 * @return void
	 */
	private function setCurDate(DateTime $date):void
	{
		$this->curDate = clone $date;
		if($this->isVocation($this->curDate)){
			$this->nextDay();
		}
	}

	/**
	 * adds one day to current date
	 *
	 * @return void
	 */
	private function nextDay(){
		$oneDay = new \DateInterval('P1D');
		do {
			$this->curDate->add($oneDay);
		} while($this->isVocation($this->curDate));
		if($this->curDate > $this->endDate)
			$this->curDate = null;
	}

	/**
	 * removes object from objects array
	 *
	 * @return void
	 */
	private function removeObjectFromObjects(){
		$object_id = $this->object->id;
		//remove object from total objects
		if($this->objects->contains( 'id', $object_id)){
			$this->objects = $this->objects->reject( function($item, $key) use($object_id) {
				return $item->id == $object_id;
			});
		}
	}

	/**
	 * sets current object from district objects and removes it from total objects
	 *
	 * @return void
	 */
	private function nextObjectInDistrict(){
		if($this->district['objects']->count() > 0){
			$object = $this->district['objects']->pop();
			$this->districtOject = $object;
			$this->object = $object->object;
			$this->removeObjectFromObjects();
		} else {
			$this->object = null;
		}
	}

	/**
	 * remove district from districts and set it as current
	 *
	 * @return void
	 */
	private function nextDistrict(){
		if($this->districts->count() > 0 ){
			$district = $this->districts->pop();
			$technicksCount = $district['technickCount'];
			if($technicksCount < 1){
				$this->nextDistrict();
			} else {
				$this->district = $district;
			}
		} else {
			$this->district = null;
		}
	}

	/**
	 * set technicks from DB
	 *
	 * @return void
	 */
	private function fillTechnicks(){
		$this->technicks = User::where('is_admin',0)->get();
	}

	private function setStartDate(DateTime $date = null){
		if(is_null($date))
			$date = new \DateTime();
		$this->startDate = $date;
	}

	private function fillVocations(){
		$vocations = DB::select('select `vocation_date` from vocations');
		$vocationsArray = collect($vocations)->map( function($item, $key) {
			return $item->vocation_date;
		});
		$this->vocations = collect($vocationsArray);
	}

	private function fillDistricts(){
		$districts = District::all();
		foreach($districts as $district){
			$this->districts[] = [
				'technickCount' => $district->users()->count(),
				'technicks' => $district->users()->get(),
				'objects'       => $district->objects()->get(),
			];
		}
		$this->districts = collect($this->districts);
	}

	/**
	 * sets last date of plan
	 *
	 * @param  string $endYear
	 *
	 * @return void
	 */
	private function setEndDate(string $endYear = null) {
		if(is_null($endYear)){
			$endYear = $this->startDate->format('Y');
		} else {
			$endYear = (int) $endYear;
			if($endYear>2000 && $endYear<2100)
			{
				$endYear = (int) $endYear;
			} else {
				$endYear = $this->startDate->format('Y');
			}
		}
		$this->endDate = DateTime::createFromFormat('d-m-Y','31-12-'.$endYear);
	}

	/**
	 * isWorkDay function checks the date for workDay
	 *
	 * @param  DateTime $date
	 *
	 * @return bool
	 */
	private function isWorkDay(DateTime $date):bool {
		return !$this->isVocation($date);
	}

	/**
	 * isVocation function checks the date for vocation day
	 *
	 * @param  DateTime $date
	 *
	 * @return bool
	 */
	private function isVocation(DateTime $date):bool {
		return $this->vocations->contains($date->format('Y-m-d'));
	}
}