<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use \App\Services\ReglamentPlanService;

class ReglamentPlanServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register():void
    {
        $this->app->bind('reglamentPlan', \App\Services\ReglamentPlanService::class);
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
