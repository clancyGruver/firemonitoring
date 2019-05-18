<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class ObjectDeviceReglament extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('object_device_reglament', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('object_device_id');  
            $table->unsignedBigInteger('admin_id');
            $table->unsignedBigInteger('technik_id');          
            $table->boolean('is_active')->default(1);
            $table->timestamps();

            $table->foreign('admin_id')->references('id')->on('users');
            $table->foreign('technik_id')->references('id')->on('users');
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
        Schema::dropIfExists('object_device_reglament');
        //
    }
}
