import 'package:del_cafeshop/common/widgets/images/circular_image.dart';
import 'package:del_cafeshop/features/personalization/screens/profile/profile.dart';
import 'package:del_cafeshop/utils/constants/colors.dart';
import 'package:del_cafeshop/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({super.key, required Future? Function() onPressed});

  // Ambil username dan email dari SharedPreferences
  Future<Map<String, String>> _getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username') ?? 'Pengguna'; // Default 'Pengguna' jika tidak ada
    final email = prefs.getString('email') ?? 'Email belum diatur'; // Default jika email tidak ditemukan
    return {'username': username, 'email': email};
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, String>>(
      future: _getUserData(), // Ambil data username dan email dari SharedPreferences
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator()); // Menunggu data
        }

        if (snapshot.hasError) {
          return Center(child: Text('Terjadi kesalahan: ${snapshot.error}'));
        }

        final userData = snapshot.data ?? {'username': 'Pengguna', 'email': 'Email belum diatur'}; // Ambil data user
        final username = userData['username']!;
        final email = userData['email']!;

        return ListTile(
          leading: const CircularImages(image: TImages.user, width: 50, height: 50, padding: 0),
          title: Text(username, style: Theme.of(context).textTheme.headlineSmall!.apply(color: TColors.white)),
          subtitle: Text(email, style: Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white)),
          trailing: IconButton(
            onPressed: () => Get.to(() => const ProfileScreen()),
            icon: const Icon(Iconsax.edit, color: TColors.white),
          ),
        );
      },
    );
  }
}
