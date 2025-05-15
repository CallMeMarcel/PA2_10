<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    use HasFactory;

    protected $fillable = ['name'];

    // Model Category// Model Product
// Model Product
    public function category()
    {
        return $this->belongsTo(Category::class, 'category_id');
    }
}
