import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart'; // ganti sesuai path kamu

class CategoryService {
  static Future<List<Category>> fetchCategories() async {
    final url = Uri.parse('http://192.168.135.183:8000/admin/category/index');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Gagal mengambil data kategori');
    }


    
  }

  
}
