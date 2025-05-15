// lib/controllers/auth_controller.dart
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
  var isLoading = false.obs;

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    final url = Uri.parse('http://192.168.35.70:8000/user/login');

    try {
      isLoading(true);
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
      print('Response body: ${res.body}'); // Debug: Cetak seluruh respons

      if (res.statusCode == 200) {
        final userData = data['user'];
        final token = data['token']; // Ambil token dari respons

        if (userData != null && token != null) {
          final username = userData['username'];
          final email = userData['email'];

          // Simpan username, email, dan token ke SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('username', username);
          await prefs.setString('email', email);
          await prefs.setString('auth_token', token);

          // Debug: Verifikasi token tersimpan
          print('Token tersimpan: $token');
          print('Username tersimpan: $username');
          print('Email tersimpan: $email');

          if (rememberMe.value) {
            print('Remember me diaktifkan');
          }

          Get.snackbar('Sukses', 'Login berhasil');
          Get.offAll(() => NavigationMenu());
        } else {
          Get.snackbar('Error', 'Data pengguna atau token tidak ditemukan dalam respons.');
          print('User data: $userData, Token: $token'); // Debug: Cetak data yang hilang
        }
      } else {
        Get.snackbar('Login Gagal', data['message'] ?? 'Email atau password salah');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}