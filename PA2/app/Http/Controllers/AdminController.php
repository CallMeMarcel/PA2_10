<?php
// app/Http/Controllers/AdminController.php

namespace App\Http\Controllers;

use App\Models\Category;
use App\Models\Product;
use App\Models\Order;
use Illuminate\Http\Request;
use Inertia\Inertia;

class AdminController extends Controller
{
    public function dashboard()
    {
        $stats = [
            'kategori' => Category::count(),
            'produk' => Product::count(),
            'orders' => Order::count(),
        ];

        return Inertia::render('Admin/Dashboard', [
            'stats' => $stats
        ]);
    }

    public function kategori()
    {
        return Inertia::render('Admin/Kategori');
    }

    public function produk()
    {
        return Inertia::render('Admin/Produk');
    }
}