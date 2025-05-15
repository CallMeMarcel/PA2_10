<?php

namespace App\Http\Controllers\Admin;
use Illuminate\Support\Facades\Storage;
use App\Http\Controllers\Controller;
use App\Models\Product;
use App\Models\Category;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Redirect;
use Inertia\Inertia;

class ProductController extends Controller
{
    public function index()
{
    return Inertia::render('Admin/Produk/index', [
        'products' => Product::with('category')->latest()->get(),
        'categories' => Category::all(),
    ]);
}

    public function create()
{
    return Inertia::render('Admin/Produk/create', [
        'categories' => Category::all(),
    ]);
}
public function edit(Product $product)
{
    // Mengambil daftar kategori untuk ditampilkan di form edit
    $categories = Category::all();

    // Mengembalikan view edit dengan data produk dan kategori
    return inertia('Admin/Produk/edit', [
        'product' => $product,
        'categories' => $categories
    ]);
}

public function store(Request $request)
{
    $validated = $request->validate([
        'title' => 'required|string|max:255',
        'description' => 'required|string',
        'price' => 'required|numeric|min:0',
        'status' => 'required|in:available,unavailable',
        'category_id' => 'required|exists:categories,id',
        'image' => 'nullable|image|mimes:jpg,jpeg,png|max:2048',
    ]);

    if ($request->hasFile('image')) {
        $imagePath = $request->file('image')->store('products', 'public');
        $validated['image'] = $imagePath;
    }

    Product::create($validated);

    return Redirect::route('admin.produk.index')->with('success', 'Produk berhasil ditambahkan');
}


public function update(Request $request, Product $product)
{
    // Validasi dasar
    $validated = $request->validate([
        'title' => 'required|string|max:255',
        'description' => 'required|string',
        'price' => 'required|numeric',
        'status' => 'required|in:available,unavailable',
        'category_id' => 'required|exists:categories,id',
        'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
    ]);

    // Cek jika ada file gambar baru
    if ($request->hasFile('image')) {
        // Hapus gambar lama jika ada
        if ($product->image) {
            Storage::delete('public/' . $product->image);
        }

        // Simpan gambar baru
        $imagePath = $request->file('image')->store('products', 'public');
        $validated['image'] = $imagePath;
    }

    // Update produk
    $product->update($validated);

    return redirect()->route('admin.produk.index')->with('success', 'Produk berhasil diperbarui');
}



public function destroy($id)
{
    $product = Product::findOrFail($id);
    
    // Hapus gambar jika ada
    if ($product->image) {
        Storage::delete('public/' . $product->image);
    }

    $product->delete();

    return redirect()->route('admin.produk.index')->with('success', 'Produk berhasil dihapus');
}

}
