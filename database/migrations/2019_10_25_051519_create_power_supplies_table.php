<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreatePowerSuppliesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('device_power_supplies', function (Blueprint $table) {
            $table->bigIncrements('id');
            $table->string('name');
            $table->integer('accumulator_count')->nullable();
            $table->double('battery_capacity', 8, 2)->nullable();
            $table->integer('output_voltage')->nullable();
            $table->string('instruction')->nullable();
            $table->unsignedBigInteger('created_user_id');
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('power_supplies');
    }
}
