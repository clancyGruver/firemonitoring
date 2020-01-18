<?php
namespace App\Facades;

use Illuminate\Support\Facades\Facade;

class ReglamentPlanFacade extends Facade{
    protected static function getFacadeAccessor()
    {
        return 'reglamentPlan';
    }
}