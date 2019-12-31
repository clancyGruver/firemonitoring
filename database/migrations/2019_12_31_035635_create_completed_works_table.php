<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateCompletedWorksTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('completed_works', function (Blueprint $table) {
            $table->softDeletes();
            $table->bigIncrements('id');
            $table->integer('object_id');
            $table->integer('device_id');
            $table->integer('user_id');
            $table->integer('work_type');
            $table->string('tbl_name');
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
        Schema::dropIfExists('completed_works');
    }
}
