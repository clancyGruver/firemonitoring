<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class DeviceReglamentElement extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('device_reglament_element', function (Blueprint $table) {
            $table->smallIncrements('id');
            $table->string('text');
            $table->unsignedSmallInteger('device_reglament_id');
            $table->unsignedBigInteger('created_user_id');
            $table->boolean('is_active')->default(1);
            $table->timestamps();

            $table->foreign('created_user_id')->references('id')->on('users');
            $table->foreign('device_reglament_id')->references('id')->on('device_reglament');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('device_reglament_element');
        //
    }
}
