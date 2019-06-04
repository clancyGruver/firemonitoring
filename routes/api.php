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

Route::middleware('auth:api')->group(function(){
    Route::get('/user', function (Request $request) {
        return $request->user();
    });
});

Route::post('/raions/{id}', 'RaionController@update');
Route::post('/devices/delete/{id}', 'DevicesController@delete')->name('devices.delete');
Route::post('/devices/get', 'DevicesController@getJson')->name('devices.getJson');
Route::post('/objects/delete/{id}', 'ObjectsController@delete')->name('objects.delete');
Route::post('/objectdevice/add', 'ObjectdevicesController@add')->name('od.add');
Route::post('/objectdevice/get/{id}', 'ObjectdevicesController@getJson')->name('od.getJson');
