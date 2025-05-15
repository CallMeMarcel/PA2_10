<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
class Order extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',           // bisa null untuk order manual
        'order_number',      // bisa gunakan UUID atau kode unik
        'total_amount',
        'status',            // e.g., pending, completed, canceled
        'payment_status',    // e.g., unpaid, paid, failed
        'payment_method',    // e.g., cash, QRIS, transfer
        'shipping_address',  // optional, bisa null untuk dine-in
        'notes',
    ];

    protected $casts = [
        'total_amount' => 'float',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

    public function items()
    {
        return $this->hasMany(OrderItem::class);
    }

    public function getFormattedTotalAttribute()
    {
        return 'Rp ' . number_format($this->total_amount, 0, ',', '.');
    }
}
