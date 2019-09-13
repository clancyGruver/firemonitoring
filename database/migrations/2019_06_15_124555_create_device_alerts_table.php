<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateDeviceAlertsTable extends Migration
{
    /**
    * Run the migrations.
    *
    * @return void
    */
    public function up()
    {
        //Система оповещения и управления эвакуацией людей при пожаре
        //СП 3.13130.2009 Системы противопожарной защиты. Система оповещения и управления эвакуацией людей при пожаре. Требования пожарной безопасностиc
        Schema::create('device_alerts', function (Blueprint $table) {
            $table->bigIncrements('id');

            $table->string('name');
            $table->set('type',['sound','voice','light']);
            $table->double('power');
            $table->unsignedBigInteger('created_user_id');

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
        Schema::dropIfExists('device_alerts');
    }
}
