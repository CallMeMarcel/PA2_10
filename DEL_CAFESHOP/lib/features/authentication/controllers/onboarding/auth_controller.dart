import 'dart:convert';
import 'package:del_cafeshop/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rememberMe = false.obs;
  final formKey = GlobalKey<FormState>();

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    final url = Uri.parse('http://192.168.135.183:8000/user/login');

    try {
      final res = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
        }),
      );

      final data = jsonDecode(res.body);

      print('Response status: ${res.statusCode}');
      print('Response body: ${res.body}');

      if (res.statusCode == 200) {
        final user = data['user'];
        if (user != null) {
          final username = user['username'];
          final email = user['email'];  // Ambil email dari respons server

          // Simpan username dan email ke SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('username', username);
          await prefs.setString('email', email);  // Simpan email ke SharedPreferences

          if (rememberMe.value) {
            // Simpan token atau data lain jika diperlukan
            print('Remember me is enabled');
          }

          Get.snackbar('Sukses', 'Login berhasil');
          Get.offAll(() => NavigationMenu());
        } else {
          Get.snackbar('Error', 'Username atau email tidak ditemukan dalam respons server.');
        }
      } else {
        Get.snackbar('Login Gagal', data['message'] ?? 'Email atau password salah');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: ${e.toString()}');
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
