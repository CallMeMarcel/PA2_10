import 'package:del_cafeshop/common/widgets/appbar/appbar.dart';
import 'package:del_cafeshop/common/widgets/images/circular_image.dart';
import 'package:del_cafeshop/common/widgets/texts/section_heading.dart';
import 'package:del_cafeshop/features/personalization/screens/profile/widgets/profile_menu.dart';
import 'package:del_cafeshop/features/personalization/screens/settings/settings.dart';
import 'package:del_cafeshop/utils/constants/image_strings.dart';
import 'package:del_cafeshop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppbar(
        showBackArrow: true,
        title: Text('Profile'),
      ),
      /// Body 
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace) ,
          child: Column(
            children: [
              // Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                     const CircularImages(image: TImages.user, width: 80, height: 80),
                     TextButton(onPressed: (){}, child: const Text('Change Profile Picture'))
                  ],
                ),
              ),

              // Details
              const SizedBox(height: TSizes.spaceBtwItems / 2,),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              /// Heading Profile Information
              const SectionHeading(title: 'Profile Information', showActionButton: false),
              const SizedBox(height: TSizes.spaceBtwItems),
              
              ProfileMenu(onPressed: () {  }, title: 'Pedro Marcel Hutagaol', value: 'Kelompok 10 D3TI 2023',),
              ProfileMenu(onPressed: () {  }, title: 'Pedroo', value: 'Kelompok 10 D3TI 2023',),

              const SizedBox(height: TSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems),

              ///Heading Personal Info
              const SectionHeading(title: 'Personal Information'),
              const SizedBox(height: TSizes.spaceBtwItems,),

              ProfileMenu(onPressed:() { } , title: 'User ID', value: '11323034'),
              ProfileMenu(onPressed:() { } , title: 'E-mail', value: 'pedromhutagaol@gamil.com'),
              ProfileMenu(onPressed:() { } , title: 'Phone Number', value: '+628-1396-5549-49'),
              ProfileMenu(onPressed:() { } , title: 'Gender', value: 'Male'),
              ProfileMenu(onPressed:() { } , title: 'Date of Birth', value: '09 Nov 2005'),

              const Divider(),
              const SizedBox(height: TSizes.spaceBtwItems,),

              Center(
                child: TextButton(
                  onPressed: () => Get.to(() => const SettingScreen()) 
                , child: const Text('Close Account' , style: TextStyle(color: Colors.red),) 
                ),
              )
             
            ],
          ),

        ),
      ),
    );
  }
}

