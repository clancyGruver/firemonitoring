<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class ObjectDeviceReglamentLimitations extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('object_device_reglament_limitations', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('object_device_id');
            $table->unsignedBigInteger('ODR_id')->nullable();
            $table->unsignedSmallInteger('DL_id');
            $table->unsignedBigInteger('created_user_id');
            $table->string('additional_limitation')->nullable();
            $table->boolean('is_active')->default(1);
            $table->timestamps();

            $table->foreign('created_user_id')->references('id')->on('users');
            $table->foreign('object_device_id')->references('id')->on('object_devices');
            $table->foreign('ODR_id')->references('id')->on('object_device_reglament');
            $table->foreign('DL_id')->references('id')->on('device_limitations');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('object_device_reglament_limitations');
        //
    }
}
