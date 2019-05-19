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



Route::get('/raions', 'RaionController@index');
Route::post('/raions/{id}', 'RaionController@update');

Route::get('/objects', 'ObjectsController@index');
Route::get('/objects/{id}', 'ObjectsController@getOne')->where('id', '[0-9]+');
Route::post('/objects/{id}', 'ObjectsController@update')->where('id', '[0-9]+');
Route::post('/objects/create', 'ObjectsController@create');