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
});

Route::post('/raions/{id}', 'RaionController@update');

Route::post('/devices/delete/{id}', 'DevicesController@delete')->name('devices.delete');
Route::post('/devices/get', 'DevicesController@getJson')->name('devices.getJson');
Route::post('/devices/getbyclass', 'DevicesController@getByClassJson')->name('devices.getbyclassJson');

Route::post('/antennas/delete/{id}', 'DeviceAntennaController@delete')->name('antennas.delete');

Route::post('/rspi/delete/{id}', 'DeviceRspiController@delete')->name('rspi.delete');

Route::post('/sys_alert/delete/{id}', 'DeviceSystemVoiceAlertController@delete')->name('sys_alert.delete');
Route::post('/alert/delete/{id}', 'DeviceAlertController@delete')->name('alert.delete');
Route::post('/sys_alert_dev/store', 'DeviceSystemVoiceAlertsDevController@store')->name('sys_alert_dev.store');
Route::post('/sys_alert_dev/storeCoords', 'DeviceSystemVoiceAlertsDevController@storeCoords')->name('sys_alert_dev.storeCoords');

Route::post('/objects/delete/{id}', 'ObjectsController@delete')->name('objects.delete');
Route::post('/objects/fileUpload', 'ObjectsController@fileUpload')->name('objects.fileUpload');
Route::post('/objects/fileDelete/{id}', 'ObjectsController@fileDelete')->name('objects.fileDelete');
Route::post('/objects/btiFiles/{id}', 'ObjectsController@btiFiles')->name('objects.btiFiles');

Route::post('/objectdevice/add', 'ObjectdevicesController@add')->name('od.add');
Route::post('/objectdevice/get/{id}', 'ObjectdevicesController@getJson')->name('od.getJson');
Route::post('/objectdevice/store', 'ObjectdevicesController@storeJson')->name('od.storeJson');
Route::post('/objectdevice/delete/{id}', 'ObjectdevicesController@deleteJson')->name('od.deleteJson');
Route::post('/objectdevice/storeCoords/{id}', 'ObjectdevicesController@storeCoordsJson')->name('od.storeCoords');

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
Route::post('/wire/delete/{id}', 'WiresController@deleteJson')->name('wires.deleteJson');

Route::post('/antenna/storeParams/{id?}', 'DeviceAntennaController@storeParams')->name('antenna.storeParams');
