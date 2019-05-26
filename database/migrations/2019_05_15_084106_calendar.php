<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class Calendar extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('calendar', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('admin_id');  
            $table->unsignedBigInteger('technik_id');  
            $table->unsignedBigInteger('object_id');  
            $table->unsignedBigInteger('device_id')->nullable();  
            $table->set('job_type', ['repair', 'reglament', 'installation']);
            $table->set('reglament_dev_type', ['sensor', 'wire', 'device'])->nullable();
            $table->unsignedBigInteger('reglament_id')->nullable();  
            $table->string('comment')->nullable();  
            $table->boolean('is_active')->default(1);
            $table->timestamps();

            $table->foreign('admin_id')->references('id')->on('users');
            $table->foreign('technik_id')->references('id')->on('users');
            $table->foreign('object_id')->references('id')->on('objects');
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
        Schema::dropIfExists('calendar');
        //
    }
}
