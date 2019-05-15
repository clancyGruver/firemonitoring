<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class WireSensorReglament extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('wire_sensor_reglament', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('wire_sensor_id');       
            $table->unsignedBigInteger('created_user_id');
            $table->boolean('is_active')->default(1);
            $table->timestamps();

            $table->foreign('created_user_id')->references('id')->on('users');
            $table->foreign('wire_sensor_id')->references('id')->on('wire_sensor');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('wire_sensor_reglament');
        //
    }
}
