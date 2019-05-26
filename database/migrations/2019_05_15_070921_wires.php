<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class Wires extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('wires', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('object_device_id');
            $table->unsignedBigInteger('created_user_id');
            $table->boolean('is_good')->default(1);
            $table->string('description');
            $table->string('sertificate');
            $table->boolean('is_fire_safety')->default(1);
            $table->boolean('is_active')->default(1);
            $table->timestamps();

            $table->foreign('created_user_id')->references('id')->on('users');
            $table->foreign('object_device_id')->references('id')->on('object_devices');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('wires');
        //
    }
}
