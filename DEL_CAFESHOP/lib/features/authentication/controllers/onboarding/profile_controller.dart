// lib/features/authentication/controllers/onboarding/profile_controller.dart
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
      );

      // Perbarui data pengguna lokal
      user.value = updatedUser;

      // Perbarui SharedPreferences jika email berubah
      await prefs.setString('email', email);
      await prefs.setString('username', username);

      Get.snackbar('Sukses', 'Profil berhasil diperbarui');
      Get.back(); // Kembali ke ProfileScreen
    } catch (e) {
      Get.snackbar('Error', 'Gagal memperbarui profil: $e');
    } finally {
      isLoading(false);
    }
  }
}