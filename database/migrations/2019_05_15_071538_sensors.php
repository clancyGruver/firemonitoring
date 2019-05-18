<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class Sensors extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('sensors', function (Blueprint $table) {
            $table->bigIncrements('id');
            //Классификация ПИ 
            $table->boolean('is_automate')->default(1);//По способу приведения в действие: автоматические и ручные
            $table->set('power_supply', ['wire', 'separate wire', 'stand-alone']);//По способу электропитания: питаемые по шлейфу; питаемые по отдельному проводу; автономные.
            $table->boolean('is_address');//По возможности установки адреса: адресные и безадресные.

            //Общая классификация автономных ПИ
            $table->set('standalon_function', ['smoke', 'fire'])->nullable();//По функциональным возможностям автономные ПИ разделяют на два типа: автономные дымовые пожарные извещатели и автономные комбинированные пожарные извещатели
            $table->boolean('standalon_smoke_is_radioisotop')->nullable();//По принципу обнаружения пожара автономные дымовые пожарные извещатели разделяют на два типа: автономные пожарные извещатели оптико-электронные, автономные пожарные извещатели радиоизотопные
            
            //Общая классификация автоматических ПИ
            $table->set('automate_attribute', ['heat', 'smoke', 'fire', 'gas', 'combine'])->nullable();//По виду контролируемого признака пожара автоматические ПИ подразделяют на: тепловые; дымовые; пламени; газовые; комбинированные.        
            $table->set('automate_reaction', ['maximal', 'differincial', 'max-diff'])->nullable();//По характеру реакции на контролируемый признак: максимальные, дифференциальные и максимально-дифференциальные

            $table->unsignedBigInteger('created_user_id');
            $table->boolean('is_active')->default(1);
            $table->timestamps();

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
        Schema::dropIfExists('sensors');
        //
    }
}
