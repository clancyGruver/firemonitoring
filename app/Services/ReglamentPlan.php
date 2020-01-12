<?php
namespace App\Services;
use App\User;
use DateTime;
use Illuminate\Support\Facades\DB;
use App\MonitoringObject as MO;
use App\District;
use App\reglament_works;

class ReglamentPlan {
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

	function __construct(string $endYear = null) {
		$this->setCurDate(new \DateTime());
		$this->fillDistricts();
		$this->objects = MO::all();
		$this->setEndDate($endYear);
		$this->fillVocations();
		$this->fillTechnicks();
	}

	public function createYearPlan(){
		$nextDay = [];
		while($this->curDate <= $this->endDate){
			while(!is_null($this->district)){
				$timeLeft = $this->district['technickCount'] * $this->technickWorkTime;
				while($this->object){
					$devices = $this->object->devices;
					foreach($devices as $device){
						foreach($device->reglaments as $reglament){
							if($timeLeft - $reglament->duration > 0){
								$timeLeft -= $reglament->duration;
								$this->planCalendar[] = [
									'date'         => $this->curDate,
									'district_id'  => $this->district->id,
									'object_id'    => $this->object->object_id,
									'device_id'    => $device->device_id,
									'reglament_id' => $reglament->id,
									'tbl_name'     => $device->tbl_name,
								];
							} else {
								$nextDay[] = [
									'duration'     => $reglament->duration,
									'district_id'  => $this->district->id,
									'object_id'    => $this->object->object_id,
									'device_id'    => $device->device_id,
									'reglament_id' => $reglament->id,
									'tbl_name'     => $device->tbl_name,
								];
							}
						}
					}
					$this->nextObjectInDistrict();
				}
			}
			if($this->objects->count() > 0){
				$this->nextObject();
			}
			$this->nextDay();
		}
	}

	private function nextObject(){
		if($this->objects->count() > 0){
			$this->object = $this->objects->pop();
		}
	}

	private function nextDay(){
		$oneDay = new \DateInterval('P1D');
		do {
			$this->curDate->add($oneDay);
		} while($this->isWorkDay($this->curDate));
	}

	private function removeObjectFromObjects(){
		$object_id = $this->object->object_id;
		//remove object from total objects
		if($this->objects->contains( 'id', $object_id)){
			$this->objects = $this->objects->reject( function($item, $key) use($object_id) {
				return $item->id == $object_id;
			});
		}
	}

	private function nextObjectInDistrict(){
		if($this->district['objects']->count() > 0){
			$this->object = $this->district['objects']->pop();
		} else {
			$this->object = null;
		}
		$this->removeObjectFromObjects();
	}

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

	private function fillTechnicks(){
		$this->technicks = User::where('is_admin',0)->get();
	}

	private function setCurDate(DateTime $date){
		$this->curDate = $date;
		if($this->isVocation($date)){
			$this->nextDay();
		}
	}

	private function fillVocations(){
		$vocations = DB::select('select `vocation_date` from vocations');
		$this->vocations = collect($vocations)->map( function($item, $key) {
			return $item->vocation_date;
		});
	}

	private function fillDistricts(){
		$districts = District::all();
		foreach($districts as $district){
			$this->districts[] = [
				'technickCount' => $district->users()->count(),
				'objects'       => $district->objects()->get(),
			];
		}
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
			$endYear = $this->curDate->format('Y');
		} else {
			$endYear = (int) $endYear;
			if($endYear>2000 && $endYear<2100)
			{
				$endYear = (int) $endYear;
			} else {
				$endYear = $this->curDate->format('Y');
			}
		}
		$this->endDate = DateTime::createFromFormat('DD-MM-YY','31-12-'.$endYear);
	}

	/**
	 * isWorkDay function checks the date for workDay
	 *
	 * @param  DateTime $date
	 *
	 * @return bool
	 */
	private function isWorkDay(DateTime $date):bool {
		return !$this->vocations->contains($date->format('Y-m-d'));
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