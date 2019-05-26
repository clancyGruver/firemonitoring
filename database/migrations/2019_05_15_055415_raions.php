<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class Raions extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('raions', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('name');
            $table->decimal('lng', 10, 7);
            $table->decimal('lat', 10, 7);
            $table->boolean('is_active')->default(1);            
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
        Schema::dropIfExists('raions');
    }
}
