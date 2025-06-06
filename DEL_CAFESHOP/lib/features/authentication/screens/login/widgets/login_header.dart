import 'package:del_cafeshop/utils/constants/image_strings.dart';
import 'package:del_cafeshop/utils/constants/sizes.dart';
import 'package:del_cafeshop/utils/constants/text_strings.dart';
import 'package:del_cafeshop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
    
  });


  @override
  Widget build(BuildContext context) {
    final dark= THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          height: 150,
          image: AssetImage(dark ? TImages.darkAppLogo : TImages.lightAppLogo),
          ),
          Text(TTexts.loginTitle,style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: TSizes.sm),
          Text(TTexts.loginSubTitle,style: Theme.of(context).textTheme.bodyMedium),
      ],
    );
  }
}