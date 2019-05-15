<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class Objects extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('objects', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('name');
            $table->unsignedBigInteger('raion_id');
            $table->string('address');
            $table->decimal('lng', 10, 7);
            $table->decimal('lat', 10, 7);
            $table->boolean('is_active')->default(1);
            $table->string('contact_name');
            $table->string('contact_phone');
            $table->string('director_name');
            $table->string('director_phone');
            $table->unsignedBigInteger('created_user_id');
            $table->timestamps();

            $table->foreign('raion_id')->references('id')->on('raions');
            $table->foreign('created_user_id')->references('id')->on('users');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('objects');
        //
    }
}
