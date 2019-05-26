<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class AddObjectsDocumentation extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('objects', function($table) {
            $table->boolean('project_isset')->nullable()->default(0);;
            $table->string('project_cipher')->nullable();
            $table->year('project_year')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('objects', function($table) {
            $table->dropColumn('project_isset');
            $table->dropColumn('project_cipher');
            $table->dropColumn('project_year');
        });
    }
}
