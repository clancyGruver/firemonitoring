<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class ObjectRepairQueue extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('object_repair_queue', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('object_id');  
            $table->unsignedBigInteger('device_id');  
            $table->set('type', ['sensor', 'wire', 'device']);
            $table->string('technik_comment')->nullable();
            $table->unsignedBigInteger('finder_id');
            $table->unsignedBigInteger('repairer_id');
            $table->unsignedBigInteger('broken_object_id');
            $table->unsignedBigInteger('limitation_id')->nullable();
            $table->boolean('is_active')->default(1);
            $table->timestamps();

            $table->foreign('finder_id')->references('id')->on('users');
            $table->foreign('repairer_id')->references('id')->on('users');
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
        Schema::dropIfExists('object_repair_queue');
        //
    }
}
