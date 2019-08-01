<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class DeviceLimitations extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('device_limitations', function (Blueprint $table) {
            $table->smallIncrements('id');
            $table->unsignedBigInteger('device_id');
            $table->string('text');
            $table->unsignedBigInteger('created_user_id');
            $table->softDeletes();
            $table->timestamps();

            $table->foreign('created_user_id')->references('id')->on('users');
            $table->foreign('device_id')->references('id')->on('devices');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('device_limitations');
        //
    }
}
