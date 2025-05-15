// lib/features/authentication/controllers/onboarding/profile_controller.dart
import 'dart:io';
import 'package:get/get.dart';
import 'package:del_cafeshop/data/models/user.dart';
import 'package:del_cafeshop/data/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;
  var user = Rxn<User>();
  final ApiService apiService = ApiService();

  @override
  void onInit() {
    fetchProfile();
    super.onInit();
  }

  Future<void> fetchProfile() async {
    try {
      isLoading(true);
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      print('Token di ProfileController: $token');
      if (token == null) {
        throw Exception('Token tidak ditemukan');
      }

      final fetchedUser = await apiService.fetchUserProfile(token);
      user.value = fetchedUser;
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat profil: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateProfile({
    required String name,
    required String username,
    required String email,
    required String phone,
    String? imageUrl,
  }) async {
    try {
      isLoading(true);
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token == null) {
        throw Exception('Token tidak ditemukan');
      }

      final updatedUser = await apiService.updateUserProfile(
        token: token,
        name: name,
        username: username,
        email: email,
        phone: phone,
        imageUrl: imageUrl,
      );

      user.value = updatedUser;
      await prefs.setString('email', email);
      await prefs.setString('username', username);

      Get.snackbar('Sukses', 'Profil berhasil diperbarui');
      print('Navigasi kembali ke ProfileScreen');
      Get.back();
    } catch (e) {
      Get.snackbar('Error', 'Gagal memperbarui profil: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> uploadProfileImage(File image) async {
    try {
      isLoading(true);
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('auth_token');
      if (token == null) {
        throw Exception('Token tidak ditemukan');
      }

      final imageUrl = await apiService.uploadProfileImage(token, image);
      
      // Perbarui user dengan imageUrl baru
      if (user.value != null) {
        final updatedUser = await apiService.updateUserProfile(
          token: token,
          name: user.value!.name,
          username: user.value!.username,
          email: user.value!.email,
          phone: user.value!.phone,
          imageUrl: imageUrl,
        );
        user.value = updatedUser;
      }

      Get.snackbar('Sukses', 'Foto profil berhasil diunggah');
    } catch (e) {
      Get.snackbar('Error', 'Gagal mengunggah foto profil: $e');
    } finally {
      isLoading(false);
    }
  }
}