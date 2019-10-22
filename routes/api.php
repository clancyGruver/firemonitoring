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

	Route::post('/devices/delete/{type}/{id}', 'DevicesController@delete')->name('devices.delete');
	Route::post('/devices/get', 'DevicesController@getJson')->name('devices.getJson');
	Route::post('/devices/getbyclass', 'DevicesController@getByClassJson')->name('devices.getbyclassJson');
	Route::post('/devices/add/{type}', 'DevicesController@add');
	Route::post('/devices/update/{type}/{id}', 'DevicesController@update');

	Route::post('/antennas/delete/{id}', 'DeviceAntennaController@delete');
	Route::post('/antenna/storeParams', 'DeviceAntennaController@storeParams');

	Route::post('/rspi/delete/{id}', 'DeviceRspiController@delete')->name('rspi.delete');
	Route::post('/rspi/storeParams', 'DeviceRspiController@storeParams')->name('rspi.storeParams');

	Route::post('/sys_alert/delete/{id}', 'DeviceSystemVoiceAlertController@delete')->name('sys_alert.delete');
	Route::post('/alert/delete/{id}', 'DeviceAlertController@delete')->name('alert.delete');
	Route::post('/sys_alert_dev/store', 'DeviceSystemVoiceAlertsDevController@store')->name('sys_alert_dev.store');
	Route::post('/sys_alert_dev/storeCoords/{id}', 'DeviceSystemVoiceAlertsDevController@storeCoords')->name('sys_alert_dev.storeCoords');

	Route::post('/objects', 'ObjectsController@indexJson')->name('objects.indexJson');
	Route::post('/objects/delete/{id}', 'ObjectsController@delete')->name('objects.delete');
	Route::post('/objects/update/{id}', 'ObjectsController@updateJson')->name('objects.updateJson');
	Route::post('/objects/fileUpload', 'ObjectsController@fileUpload')->name('objects.fileUpload');
	Route::post('/objects/fileDelete/{id}', 'ObjectsController@fileDelete')->name('objects.fileDelete');
	Route::post('/objects/btiUpload', 'ObjectsController@btiUpload')->name('objects.btiUpload');
	Route::post('/objects/btiDelete/{id}', 'ObjectsController@btiDelete')->name('objects.btiDelete');
	Route::post('/objects/btiFiles/{id}', 'ObjectsController@btiFiles')->name('objects.btiFiles');
	Route::post('/objects/storeCoords/{id}', 'ObjectsController@storeCoords')->name('objects.storeCoords');
	Route::post('/objects/limited', 'ObjectsController@limited');
	Route::post('/objects/addObject', 'ObjectsController@addObject');


	Route::post('/objectdevice/add', 'ObjectdevicesController@add')->name('od.add');
	Route::post('/objectdevice/get/{id}', 'ObjectdevicesController@getJson')->name('od.getJson');
	Route::post('/objectdevice/store', 'ObjectdevicesController@storeJson')->name('od.storeJson');
	Route::post('/objectdevice/delete/{id}', 'ObjectdevicesController@deleteJson')->name('od.deleteJson');
	Route::post('/objectdevice/storeCoords/{id}', 'ObjectdevicesController@storeCoordsJson')->name('od.storeCoords');
	Route::post('/objectdevice/isgood/{id}', 'ObjectdevicesController@isgood')->name('objectdevice.isgood');
	Route::post('/objectdevice/storeSetupYear/{id}', 'ObjectdevicesController@storeSetupYear');

	Route::post('/sensors/getall', 'SensorController@getAllJson')->name('sensors.getAllJson');
	Route::post('/sensors/store', 'SensorController@storeJson')->name('sensors.storeJson');
	Route::post('/sensors/update', 'SensorController@updateJson')->name('sensors.updateJson');
	Route::post('/sensors/delete', 'SensorController@deleteJson')->name('sensors.deleteJson');

	Route::post('/sensorwire/add', 'SensorWireController@addJson')->name('sensorwire.addJson');
	Route::post('/sensorwire/update', 'SensorWireController@updateJson')->name('sensorwire.updateJson');
	Route::post('/sensorwire/delete/{id}', 'SensorWireController@deleteJson')->name('sensorwire.deleteJson');
	Route::post('/sensorwire/storeCoords/{id}', 'SensorWireController@storeCoordsJson')->name('sensorwire.storeCoords');

	Route::post('/wire/store', 'WiresController@storeJson')->name('wires.storeJson');
	Route::post('/wire/update/{id}', 'WiresController@updateJson')->name('wires.updateJson');
	Route::post('/wire/delete/{id}', 'WiresController@deleteJson');

	Route::post('/limitations/update/{id}', 'DeviceLimitationsController@update');
	Route::post('/limitations/insert', 'DeviceLimitationsController@insert');
	Route::post('/limitations/delete/{id}', 'DeviceLimitationsController@delete');
	Route::post('/limitations/get', 'DeviceLimitationsController@get');
	Route::post('/limitations/get/{id}', 'DeviceLimitationsController@getById');
	Route::post('/limitations/set/{id}', 'DeviceLimitationsController@setById');

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
});
