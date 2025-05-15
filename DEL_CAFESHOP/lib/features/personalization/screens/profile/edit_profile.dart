// lib/features/personalization/screens/profile/edit_profile.dart
import 'package:del_cafeshop/common/widgets/appbar/appbar.dart';
import 'package:del_cafeshop/features/authentication/controllers/onboarding/profile_controller.dart';
import 'package:del_cafeshop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProfileController>();
    final formKey = GlobalKey<FormState>();

    // Inisialisasi controller teks dengan data pengguna saat ini
    final nameController = TextEditingController(text: controller.user.value?.name ?? '');
    final usernameController = TextEditingController(text: controller.user.value?.username ?? '');
    final emailController = TextEditingController(text: controller.user.value?.email ?? '');
    final phoneController = TextEditingController(text: controller.user.value?.phone ?? '');

    return Scaffold(
      appBar: const TAppbar(
        showBackArrow: true,
        title: Text('Edit Profil'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.user.value == null) {
          return const Center(child: Text('Gagal memuat data pengguna'));
        }

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Field Nama
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Nama'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nama tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),

                  // Field Username
                  TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(labelText: 'Username'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Username tidak boleh kosong';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),

                  // Field Email
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'E-mail'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'E-mail tidak boleh kosong';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                        return 'Format e-mail tidak valid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),

                  // Field Nomor Telepon
                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(labelText: 'Nomor Telepon'),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Nomor telepon tidak boleh kosong';
                      }
                      if (!RegExp(r'^\d{10,15}$').hasMatch(value)) {
                        return 'Format nomor telepon tidak valid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Tombol Simpan
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          await controller.updateProfile(
                            name: nameController.text.trim(),
                            username: usernameController.text.trim(),
                            email: emailController.text.trim(),
                            phone: phoneController.text.trim(),
                          );
                        }
                      },
                      child: const Text('Simpan Perubahan'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}