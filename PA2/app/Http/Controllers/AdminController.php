<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;

class AdminController extends Controller
{
    // Hapus constructor, middleware ditangani di routes
    // public function __construct()
    // {
    //     $this->middleware(['auth', 'admin']); // Tidak perlu
    // }

    // Dashboard Admin
    public function dashboard()
    {
        return Inertia::render('Admin/Dashboard');
    }

    // Halaman Kategori Produk
    public function kategori()
    {
        return Inertia::render('Admin/Kategori');
    }

    // Halaman Produk
    public function produk()
    {
        return Inertia::render('Admin/Produk');
    }
}
