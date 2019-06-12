<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class WireSensorPreviousStateChange extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('wire_sensor_previous_state', function ($table) {
            $table->unsignedBigInteger('wire_id');
            $table->unsignedBigInteger('sensor_id');           
            $table->dropColumn('wire_sensor_reglament_id');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
    }
}
