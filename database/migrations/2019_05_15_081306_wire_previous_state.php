<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class WirePreviousState extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('wire_previous_state', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('wire_id');            
            $table->unsignedBigInteger('created_user_id');
            $table->boolean('is_good')->default(1);
            $table->string('description');
            $table->string('sertificate');
            $table->boolean('is_fire_safety')->default(1);
            $table->boolean('is_active')->default(1);
            $table->timestamps();

            $table->foreign('created_user_id')->references('id')->on('users');
            $table->foreign('wire_id')->references('id')->on('wires');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('wire_previous_state');
        //
    }
}
