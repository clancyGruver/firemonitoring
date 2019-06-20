<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateDeviceSystemVoiceAlertsDevsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('device_system_voice_alerts_devs', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('device_system_voice_alerts_id');
            $table->unsignedBigInteger('device_alerts_id');
            $table->unsignedBigInteger('created_user_id');

            $table->foreign('device_alerts_id')->references('id')->on('device_alerts');
            $table->foreign('device_system_voice_alerts_id','fk_dsva')->references('id')->on('device_system_voice_alerts');
            $table->foreign('created_user_id')->references('id')->on('users');
            $table->softDeletes();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('device_system_voice_alerts_devs');
    }
}
