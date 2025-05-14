<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class RemoveNameFromProductsTable extends Migration
{
    public function up()
    {
        Schema::table('products', function (Blueprint $table) {
            $table->dropColumn('name'); // Menghapus kolom name
        });
    }

    public function down()
    {
        Schema::table('products', function (Blueprint $table) {
            $table->string('name'); // Menambahkan kembali kolom name jika rollback
        });
    }
}
