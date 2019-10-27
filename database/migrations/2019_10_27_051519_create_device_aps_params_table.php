<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateDeviceApsParamsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('device_aps_params', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->unsignedBigInteger('device_id');
            $table->integer('accumulator_isset')->nullable();
            $table->integer('accumulator_count')->nullable();
            $table->double('battery_capacity', 8, 2)->nullable();
            $table->integer('output_voltage')->nullable();
            $table->unsignedBigInteger('created_user_id');

            $table->foreign('created_user_id')->references('id')->on('users');
            $table->softDeletes();
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
        Schema::dropIfExists('device_aps_params');
    }
}
