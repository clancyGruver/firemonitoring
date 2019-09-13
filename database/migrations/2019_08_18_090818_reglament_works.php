<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class ReglamentWorks extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('reglament_works', function ($table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('reglament_id');
            $table->unsignedBigInteger('device_id');
            $table->softDeletes();
            $table->timestamp('done_at')->nullable();
            $table->timestamp('planned_reglament_at')->nullable();

            $table->foreign('reglament_id')->references('id')->on('device_reglament');
            $table->foreign('device_id')->references('id')->on('object_devices');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        //
    }
}
