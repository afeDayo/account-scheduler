<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('balance_increments', function (Blueprint $table) {
        $table->id();
        $table->foreignId('balance_id')
              ->constrained()
              ->cascadeOnDelete();
        $table->bigInteger('amount_changed');      // will be 1000
        $table->bigInteger('resulting_balance');
        $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('balance_increments');
    }
};
