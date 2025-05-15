// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:del_cafeshop/data/models/user.dart';

class ApiService {
  static const String baseUrl = 'http://192.168.35.70:8000';
  static const String profileEndpoint = '/user/profile';

  Future<User> fetchUserProfile(String token) async {
    print('Mengirim token: $token');
    final response = await http.get(
      Uri.parse('$baseUrl$profileEndpoint'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    print('Status kode: ${response.statusCode}');
    print('Respons body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return User.fromJson(jsonData['data']);
    } else {
      throw Exception('Gagal memuat profil: ${response.statusCode}');
    }
  }

  Future<User> updateUserProfile({
    required String token,
    required String name,
    required String username,
    required String email,
    required String phone,
  }) async {
    final response = await http.put(
      Uri.parse('$baseUrl$profileEndpoint'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'name': name,
        'username': username,
        'email': email,
        'phone': phone,
      }),
    );

    print('Update status kode: ${response.statusCode}');
    print('Update respons body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return User.fromJson(jsonData['data']);
    } else {
      throw Exception('Gagal memperbarui profil: ${response.statusCode}');
    }
  }
}