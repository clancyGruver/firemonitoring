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
})->name('home');

Route::post('/login', 'Auth\LoginController@login')->name('login');
Route::get('/login', 'Auth\LoginController@showLoginForm')->name('login');

Route::get('/sessionStatus', function() {
        return ['user' => Auth::user() ? Auth::user() : null];
});

Route::middleware(['auth'])->group(function(){
    Route::get('admin/{any?}', 'admin\HomeController')->where('any', '.*');
    /*Route::prefix('admin')->group(function(){
        Route::get('/{any}', 'admin\HomeController')->name('admin')->where('any', '.*');
        Route::get('/raions', 'RaionController@index')->name('raions');
        Route::prefix('objects')->group(function(){
            Route::get('/{id?}', 'ObjectsController@index')->name('objects');
            Route::get('/detail/{id}', 'ObjectsController@detail')->name('objects.detail');
            //Route::get('/edit/{id}', 'ObjectsController@edit')->name('objects.edit');
            //Route::post('/update/{id}', 'ObjectsController@update')->name('objects.update');
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
        });*/
        /*Route::prefix('devicesClasses')->group(function(){
            Route::get('/', 'DevicesClassesController@index')->name('devicesClasses');
            Route::get('/detail/{id}', 'DevicesClassesController@detail')->name('devicesClasses.detail');
            Route::get('/edit/{id}', 'DevicesClassesController@edit')->name('devicesClasses.edit');
            Route::get('/add', 'DevicesClassesController@add')->name('devicesClasses.add');
            Route::post('/store', 'DevicesClassesController@store')->name('devicesClasses.store');
        });*/
        /*Route::prefix('object-devices')->group(function(){
            Route::get('/', 'ObjectdevicesController@index')->name('od');
            Route::get('/edit/{id}', 'ObjectdevicesController@edit')->name('od.edit');
            Route::post('/update/{id}', 'ObjectdevicesController@update')->name('od.update');
            Route::get('/add', 'ObjectdevicesController@add')->name('od.add');
            Route::post('/store', 'ObjectdevicesController@store')->name('od.store');
        });
        Route::prefix('sensors')->group(function(){
            Route::get('/', 'SensorController@index')->name('sensors');
        });
        /*Route::prefix('users')->group(function(){
            Route::get('/', 'UserController@index')->name('users');
            Route::get('/edit/{id}', 'UserController@edit')->name('users.edit');
            Route::post('/update/{id}', 'UserController@update')->name('users.update');
            Route::get('/add', 'UserController@add')->name('users.add');
            Route::post('/store', 'UserController@store')->name('users.store');
        });
        Route::prefix('antennas')->group(function(){
            Route::get('/', 'DeviceAntennaController@index')->name('antennas');
            Route::get('/detail/{id}', 'DeviceAntennaController@detail')->name('antennas.detail');
            Route::get('/edit/{id}', 'DeviceAntennaController@edit')->name('antennas.edit');
            Route::post('/update/{id}', 'DeviceAntennaController@update')->name('antennas.update');
            Route::get('/add', 'DeviceAntennaController@add')->name('antennas.add');
            Route::post('/store', 'DeviceAntennaController@store')->name('antennas.store');
        });

        Route::prefix('rspi')->group(function(){
            Route::get('/', 'DeviceRspiController@index')->name('rspi');
            Route::get('/detail/{id}', 'DeviceRspiController@detail')->name('rspi.detail');
            Route::get('/edit/{id}', 'DeviceRspiController@edit')->name('rspi.edit');
            Route::post('/update/{id}', 'DeviceRspiController@update')->name('rspi.update');
            Route::get('/add', 'DeviceRspiController@add')->name('rspi.add');
            Route::post('/store', 'DeviceRspiController@store')->name('rspi.store');
        });

        Route::prefix('sys_alert')->group(function(){
            Route::get('/', 'DeviceSystemVoiceAlertController@index')->name('sys_alert');
            Route::get('/detail/{id}', 'DeviceSystemVoiceAlertController@detail')->name('sys_alert.detail');
            Route::get('/edit/{id}', 'DeviceSystemVoiceAlertController@edit')->name('sys_alert.edit');
            Route::post('/update/{id}', 'DeviceSystemVoiceAlertController@update')->name('sys_alert.update');
            Route::get('/add', 'DeviceSystemVoiceAlertController@add')->name('sys_alert.add');
            Route::post('/store', 'DeviceSystemVoiceAlertController@store')->name('sys_alert.store');
        });
        Route::prefix('alert')->group(function(){
            Route::get('/', 'DeviceAlertController@index')->name('alert');
            Route::get('/detail/{id}', 'DeviceAlertController@detail')->name('alert.detail');
            Route::get('/edit/{id}', 'DeviceAlertController@edit')->name('alert.edit');
            Route::post('/update/{id}', 'DeviceAlertController@update')->name('alert.update');
            Route::get('/add', 'DeviceAlertController@add')->name('alert.add');
            Route::post('/store', 'DeviceAlertController@store')->name('alert.store');
        });
        Route::prefix('limitations')->group(function(){
            Route::get('/', 'DeviceLimitationsController@index')->name('limitations');
        });
    });*/

    Route::prefix('technician')->group(function(){
        Route::get('/', 'technician\HomeController');
    });
});
//Auth::routes();

Route::group(['middleware' => 'auth'], function () {
	Route::resource('user', 'UserController', ['except' => ['show']]);
    Route::get('user/logout', 'UserController@logout')->name('logout');
	Route::get('profile', ['as' => 'profile.edit', 'uses' => 'ProfileController@edit']);
	Route::put('profile', ['as' => 'profile.update', 'uses' => 'ProfileController@update']);
	Route::put('profile/password', ['as' => 'profile.password', 'uses' => 'ProfileController@password']);
});

