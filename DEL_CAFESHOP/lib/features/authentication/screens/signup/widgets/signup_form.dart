import 'dart:convert';
import 'package:del_cafeshop/features/authentication/screens/login/login.dart';
import 'package:del_cafeshop/features/authentication/screens/signup/widgets/terms_condition.dart';
import 'package:del_cafeshop/utils/constants/sizes.dart';
import 'package:del_cafeshop/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:http/http.dart' as http;

class FormSignUP extends StatefulWidget {
  const FormSignUP({super.key});

  @override
  State<FormSignUP> createState() => _FormSignUPState();
}

class _FormSignUPState extends State<FormSignUP> {
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false; 

  // Fungsi registrasi user
  Future<void> registerUser() async {
    final url = Uri.parse('http://192.168.35.70:8000/user/register');

    // Validasi input sebelum mengirim request
    if (nameController.text.trim().isEmpty ||
        usernameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        phoneController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      Get.snackbar('Registrasi Gagal', 'Semua field harus diisi');
      return;
    }

    // Validasi format email
    String email = emailController.text.trim();
    if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(email)) {
      Get.snackbar('Email Tidak Valid', 'Masukkan email yang valid');
      return;
    }

    // Menampilkan loading indicator
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          'name': nameController.text.trim(),
          'username': usernameController.text.trim(),
          'email': email,
          'phone_no': phoneController.text.trim(),
          'password': passwordController.text.trim(),
        }),
      );

      // Print request body untuk debugging
      print(jsonEncode({
        'name': nameController.text.trim(),
        'username': usernameController.text.trim(),
        'email': email,
        'phone_no': phoneController.text.trim(),
        'password': passwordController.text.trim(),
      }));

      // Mengecek status code dan memberikan feedback
      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        Get.to(() => const LoginScreen());
        Get.snackbar('Berhasil', data['message'] ?? 'Registrasi berhasil');
      } else {
        final data = jsonDecode(response.body);
        Get.snackbar('Registrasi Gagal', data['message'] ?? 'Coba lagi');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      // Menghentikan loading indicator
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: TTexts.name,
              prefixIcon: Icon(Iconsax.user),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          TextFormField(
            controller: usernameController,
            decoration: const InputDecoration(
              labelText: TTexts.username,
              prefixIcon: Icon(Iconsax.user_edit),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: TTexts.email,
              prefixIcon: Icon(Iconsax.direct),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email tidak boleh kosong';
              }
              if (!RegExp(r"^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$").hasMatch(value)) {
                return 'Masukkan email yang valid';
              }
              return null;
            },
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          TextFormField(
            controller: phoneController,
            decoration: const InputDecoration(
              labelText: TTexts.phoneNo,
              prefixIcon: Icon(Iconsax.call),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          TextFormField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: TTexts.password,
              prefixIcon: Icon(Iconsax.password_check),
              suffixIcon: Icon(Iconsax.eye_slash),
            ),
          ),
          const SizedBox(height: TSizes.spaceBtwInputFields),

          const TermsCondition(),
          const SizedBox(height: TSizes.spaceBtwSections),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isLoading ? null : registerUser, // Disable button while loading
              child: isLoading
                  ? const CircularProgressIndicator() // Menampilkan indikator loading
                  : const Text(TTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
