<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class MediafilesForObject extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('objects_mediafiles', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('object_id');
            $table->string('filename');
            $table->string('description')->nullable();
            $table->timestamps();

            $table->foreign('object_id')->references('id')->on('objects');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('objects_mediafiles');
        //
    }
}
