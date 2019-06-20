<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateDeviceRspisTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('device_rspi', function (Blueprint $table) {
            $table->bigIncrements('id');

            $table->string('name');
            $table->string('instruction')->nullable();
            $table->unsignedBigInteger('created_user_id');

            $table->foreign('created_user_id')->references('id')->on('users');
            $table->softDeletes();
            $table->timestamps();
        });

        Schema::create('device_rspi_params', function (Blueprint $table) {
            $table->bigIncrements('id');

            $table->string('setup_place');
            $table->boolean('battery');
            $table->boolean('power_supply');
            $table->double('capacity',4,2)->nullable();
            $table->set('coupling',['fire','fault']);
            $table->unsignedBigInteger('created_user_id');
            $table->unsignedBigInteger('device_rspi_id');

            $table->foreign('created_user_id')->references('id')->on('users');
            $table->foreign('device_rspi_id')->references('id')->on('device_rspi');
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
        Schema::dropIfExists('device_rspi');
        Schema::dropIfExists('device_rspi_params');
    }
}
