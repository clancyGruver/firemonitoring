<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class Devices extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        $table->bigIncrements('id');
        $table->string('name');
        $table->tinyInteger('wires_count');
        $table->string('instruction');
        $table->boolean('is_active')->default(1);
        $table->unsignedBigInteger('created_user_id');
        $table->timestamps();

        $table->foreign('created_user_id')->references('id')->on('users');
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        //
    }
}
