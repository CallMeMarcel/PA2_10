<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Storage;

class Product extends Model
{
    use HasFactory;

    protected $fillable = ['title', 'image', 'description', 'status', 'price', 'category_id'];

    // Relasi dengan Category
    public function category()
    {
        return $this->belongsTo(Category::class, 'category_id');
    }

    // Atribut tambahan untuk mendapatkan URL gambar dengan benar
    protected $appends = ['image_url'];

    // Method untuk mendapatkan URL gambar
    public function getImageUrlAttribute()
    {
        return $this->image ? Storage::url($this->image) : asset('images/default.png');
    }
}
