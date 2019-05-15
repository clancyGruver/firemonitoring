<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class WireSensor extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('wire_sensor_previous_state', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('wire_id');
            $table->unsignedBigInteger('sensor_id');            
            $table->unsignedBigInteger('created_user_id');
            $table->string('name');
            $table->tinyIntunsignedTinyIntegereger('floor');
            $table->string('cabinet_name');
            $table->boolean('SP5_valid')->default(1);
            $table->boolean('is_good')->default(1);
            $table->boolean('is_active')->default(1);
            $table->timestamps();

            $table->foreign('created_user_id')->references('id')->on('users');
            $table->foreign('wire_id')->references('id')->on('wires');
            $table->foreign('sensor_id')->references('id')->on('sensors');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('wire_sensor_previous_state');
        //
    }
}
