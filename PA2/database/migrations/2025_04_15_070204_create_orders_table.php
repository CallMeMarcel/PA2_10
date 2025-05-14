<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('orders', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->nullable()->constrained()->onDelete('set null');
            $table->string('order_number')->unique();
            $table->decimal('total_amount', 15, 2);
            $table->string('status')->default('pending'); // pending, completed, canceled
            $table->string('payment_status')->default('unpaid'); // unpaid, paid, failed
            $table->string('payment_method')->nullable(); // cash, qris, transfer
            $table->text('shipping_address')->nullable(); // optional untuk dine-in
            $table->text('notes')->nullable();
            $table->timestamps();
        });
        
    }

    public function down(): void
    {
        Schema::dropIfExists('orders');
    }
};