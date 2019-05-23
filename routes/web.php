<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('auth/login');
});

Route::middleware(['auth'])->group(function(){
    Route::prefix('admin')->group(function(){
        Route::get('/', 'admin\HomeController')->name('admin');        
        Route::get('/raions', 'RaionController@index')->name('raions');
        Route::prefix('objects')->group(function(){
            Route::get('/', 'ObjectsController@index')->name('objects');
            Route::get('/detail/{id}', 'ObjectsController@detail')->name('objects.detail');            
            Route::get('/edit/{id}', 'ObjectsController@edit')->name('objects.edit');
            Route::post('/update/{id}', 'ObjectsController@update')->name('objects.update');
            Route::get('/add', 'ObjectsController@add')->name('objects.add');
            Route::post('/store', 'ObjectsController@store')->name('objects.store');
        });
        Route::prefix('devices')->group(function(){
            Route::get('/', 'DevicesController@index')->name('devices');
            Route::get('/detail/{id}', 'DevicesController@detail')->name('devices.detail');
            Route::get('/edit/{id}', 'DevicesController@edit')->name('devices.edit');
            Route::post('/update/{id}', 'DevicesController@update')->name('devices.update');
            Route::get('/add', 'DevicesController@add')->name('devices.add');
            Route::post('/store', 'DevicesController@store')->name('devices.store');
        });
        Route::prefix('devicesClasses')->group(function(){
            Route::get('/', 'DevicesClassesController@index')->name('devicesClasses');
            Route::get('/detail/{id}', 'DevicesClassesController@detail')->name('devicesClasses.detail');
            Route::get('/edit/{id}', 'DevicesClassesController@edit')->name('devicesClasses.edit');
            Route::get('/add', 'DevicesClassesController@add')->name('devicesClasses.add');
            Route::post('/store', 'DevicesClassesController@store')->name('devicesClasses.store');
        });

        
    });

    Route::prefix('technician')->group(function(){
        Route::get('/', 'technician\HomeController');
    });
});
Auth::routes();

Route::get('/home', 'HomeController@index')->name('home');

Route::group(['middleware' => 'auth'], function () {
	Route::resource('user', 'UserController', ['except' => ['show']]);
	Route::get('profile', ['as' => 'profile.edit', 'uses' => 'ProfileController@edit']);
	Route::put('profile', ['as' => 'profile.update', 'uses' => 'ProfileController@update']);
	Route::put('profile/password', ['as' => 'profile.password', 'uses' => 'ProfileController@password']);
});

