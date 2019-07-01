<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddOdLl extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('object_devices', function ($table) {
            $table->unsignedBigInteger('bti_files_id')->nullable();
            $table->decimal('lng', 10, 7)->nullable();;
            $table->decimal('lat', 10, 7)->nullable();;

            $table->foreign('bti_files_id')->references('id')->on('bti_files');
        });
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
