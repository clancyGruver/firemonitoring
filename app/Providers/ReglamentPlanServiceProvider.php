<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Services\ReglamentPlan;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //$this->app->singleton(ReglamentPlan::class)
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        //
    }
}
