<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Order;
use Illuminate\Http\Request;
use Inertia\Inertia;

class OrderController extends Controller
{
    /**
     * Menampilkan daftar pesanan yang belum selesai.
     */
    public function index()
    {
        $orders = Order::with(['user', 'items.product'])
            ->where('status', '!=', 'selesai') // Hanya pesanan belum selesai
            ->latest()
            ->get();

        return Inertia::render('Admin/Orders/Index', [
            'orders' => $orders,
        ]);
    }

    /**
     * Menghapus pesanan dari database.
     */
    public function destroy(Order $order)
    {
        $order->delete();

        return redirect()
            ->route('admin.orders.index')
            ->with('success', 'Pesanan berhasil dihapus.');
    }

    /**
     * Menandai pesanan sebagai selesai.
     */
    public function markAsComplete(Order $order)
    {
        $order->status = 'selesai';
        $order->save();

        return redirect()->back();
    }
}