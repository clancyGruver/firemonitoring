<?php

use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

//$request->header('x-user');

Route::middleware('auth:api')->group(function(){
    Route::get('/user', function (Request $request) {
        return $request->user();
    });

	Route::post('/raions', 'RaionController@indexJson');
	Route::post('/raions/{id}', 'RaionController@update');

	Route::post('/devices/delete/{type}/{id}', 'DevicesController@delete');
	Route::post('/devices/get', 'DevicesController@getJson');
	Route::post('/devices/getbyclass', 'DevicesController@getByClassJson');
	Route::post('/devices/add/{type}', 'DevicesController@add');
	Route::post('/devices/update/{type}/{id}', 'DevicesController@update');

	Route::post('/antennas/delete/{id}', 'DeviceAntennaController@delete');
	Route::post('/antenna/storeParams', 'DeviceAntennaController@storeParams');

	Route::post('/rspi/delete/{id}', 'DeviceRspiController@delete');
	Route::post('/rspi/storeParams', 'DeviceRspiController@storeParams');

	Route::post('/aps/delete/{id}', 'DeviceApsController@delete');
	Route::post('/aps/storeParams', 'DeviceApsController@storeParams');

	Route::post('/voice_alerts/storeParams', 'DeviceSystemVoiceAlertController@storeParams');

	Route::post('/sys_alert/delete/{id}', 'DeviceSystemVoiceAlertController@delete');
	Route::post('/alert/delete/{id}', 'DeviceAlertController@delete');
	Route::post('/sys_alert_dev/store', 'DeviceSystemVoiceAlertsDevController@store');
	Route::post('/sys_alert_dev/storeCoords/{id}', 'DeviceSystemVoiceAlertsDevController@storeCoords');

	Route::post('/objects', 'ObjectsController@indexJson');
	Route::post('/objects/delete/{id}', 'ObjectsController@delete');
	Route::post('/objects/update/{id}', 'ObjectsController@updateJson');
	Route::post('/objects/fileUpload', 'ObjectsController@fileUpload');
	Route::post('/objects/fileDelete/{id}', 'ObjectsController@fileDelete');
	Route::post('/objects/btiUpload', 'ObjectsController@btiUpload');
	Route::post('/objects/btiDelete/{id}', 'ObjectsController@btiDelete');
	Route::post('/objects/btiFiles/{id}', 'ObjectsController@btiFiles');
	Route::post('/objects/storeCoords/{id}', 'ObjectsController@storeCoords');
	Route::post('/objects/limited', 'ObjectsController@limited');
	Route::post('/objects/addObject', 'ObjectsController@addObject');


	Route::post('/objectdevice/add', 'ObjectdevicesController@add');
	Route::post('/objectdevice/get/{id}', 'ObjectdevicesController@getJson');
	Route::post('/objectdevice/store', 'ObjectdevicesController@storeJson');
	Route::post('/objectdevice/delete/{id}', 'ObjectdevicesController@deleteJson');
	Route::post('/objectdevice/storeCoords/{id}', 'ObjectdevicesController@storeCoordsJson');
	Route::post('/objectdevice/isgood/{id}', 'ObjectdevicesController@isgood');
	Route::post('/objectdevice/storeSetupYear/{id}', 'ObjectdevicesController@storeSetupYear');

	Route::post('/sensors/getall', 'SensorController@getAllJson');
	Route::post('/sensors/store', 'SensorController@storeJson');
	Route::post('/sensors/update', 'SensorController@updateJson');
	Route::post('/sensors/delete', 'SensorController@deleteJson');

	Route::post('/sensorwire/add', 'SensorWireController@addJson');
	Route::post('/sensorwire/update', 'SensorWireController@updateJson');
	Route::post('/sensorwire/delete/{id}', 'SensorWireController@deleteJson');
	Route::post('/sensorwire/storeCoords/{id}', 'SensorWireController@storeCoordsJson');

	Route::post('/wire/store', 'WiresController@storeJson');
	Route::post('/wire/update/{id}', 'WiresController@updateJson');
	Route::post('/wire/delete/{id}', 'WiresController@deleteJson');

	Route::post('/reglamentElement/delete/{id}', 'ReglamentsController@deleteElement');
	Route::post('/reglamentElement/update/{id}', 'ReglamentsController@updateElement');
	Route::post('/reglamentElement/add', 'ReglamentsController@addElement');

	Route::post('/reglament/update/{id}', 'ReglamentsController@updateReglament');
	Route::post('/reglament/delete/{id}', 'ReglamentsController@deleteReglament');
	Route::post('/reglament/add', 'ReglamentsController@addReglament');
	Route::post('/reglament/getByODID/{id}', 'ReglamentsController@getReglaments');
	Route::post('/reglament/unworked', 'ReglamentsController@unworked');
	Route::post('/reglament/updateWork/{id}', 'ReglamentsController@updateWork');

	Route::post('/users/getAll', 'UserController@getAll');
	Route::post('/users/delete/{id}', 'UserController@delete');
	Route::post('/users/update/{id}', 'UserController@updateJSON');
	Route::post('/users/add', 'UserController@add');

	Route::post('/calendar/addObject', 'calendarController@addObject');

	Route::post('/district/getAll', 'DistrictController@index');
	Route::post('/district/store', 'DistrictController@store');
	Route::post('/district/update/{id}', 'DistrictController@update');
	Route::post('/district/delete/{id}', 'DistrictController@delete');

	Route::post('/districtUser/store/{id}', 'DistrictController@setUser');
	Route::post('/districtUser/update/{id}', 'DistrictController@updateUser');
	Route::post('/districtUser/delete/{id}', 'DistrictController@deleteUser');

	Route::post('/districtObject/store/{id}', 'DistrictController@setObject');
	Route::post('/districtObject/update/{id}', 'DistrictController@updateObject');
	Route::post('/districtObject/delete/{id}', 'DistrictController@deleteObject');

	Route::post('/cableTypes/getAll', 'CableTypeController@index');
	Route::post('/cableTypes/add', 'CableTypeController@add');

	Route::post('/power_supply/getAll', 'DevicePowerSupplyController@index');
	Route::post('/power_supply/getAne/{id}', 'DevicePowerSupplyController@detail');
	Route::post('/power_supply/store', 'DevicePowerSupplyController@store');
	Route::post('/power_supply/update/{id}', 'DevicePowerSupplyController@update');
	Route::post('/power_supply/delete/{id}', 'DevicePowerSupplyController@delete');

	Route::prefix('plans')->group(function(){
		Route::prefix('reglament')->group(function(){
			Route::post('/', 'PlanController@index');
			Route::post('sensors', 'PlanController@sensorsReglament');
		});
	});

	Route::prefix('limitations')->group(function(){
		Route::post('/update/{id}', 'DeviceLimitationsController@update');
		Route::post('/insert', 'DeviceLimitationsController@insert');
		Route::post('/delete/{id}', 'DeviceLimitationsController@delete');
		Route::post('/get', 'DeviceLimitationsController@get');
		Route::post('/get/{id}', 'DeviceLimitationsController@getById');
		Route::post('/set/{id}', 'DeviceLimitationsController@setById');
		Route::post('/deleteAdditional/{id}', 'DeviceLimitationsController@deleteAdditioanal');
	});

	Route::prefix('word')->group(function(){
		Route::post('/serviceabilityAct/{object_id}', 'WordController@serviceabilityAct');
	});
});