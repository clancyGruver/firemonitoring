<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateDeviceAntennasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('device_antenna', function (Blueprint $table) {
            $table->bigIncrements('id');

            $table->string('name');
            $table->string('instruction')->nullable();
            $table->unsignedBigInteger('created_user_id');

            $table->foreign('created_user_id')->references('id')->on('users');
            $table->softDeletes();
            $table->timestamps();
        });

        Schema::create('device_antenna_params', function (Blueprint $table) {
            $table->bigIncrements('id');

            $table->unsignedBigInteger('device_antenna_id');
            $table->string('setup_place');
            $table->boolean('mast_isset')->default(0);
            $table->double('mast_height',3,2)->nullable();
            $table->set('cable_type',['safety','unsfety','radio']);
            $table->unsignedBigInteger('created_user_id');

            $table->foreign('created_user_id')->references('id')->on('users');
            $table->foreign('device_antenna_id')->references('id')->on('device_antenna');
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
        Schema::dropIfExists('device_antenna');
        Schema::dropIfExists('device_antenna_params');
    }
}
