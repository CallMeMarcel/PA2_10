import 'package:del_cafeshop/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:del_cafeshop/utils/constants/sizes.dart';
import 'package:del_cafeshop/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: TDeviceUtils.getAppBarHeight(),
      right: TSizes.defaultSpace, 
      child: TextButton(
        onPressed: () => OnboardingController.instance.skipPage(), 
        child: const Text('Skip')));
  }
}