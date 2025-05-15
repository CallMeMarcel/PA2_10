import 'package:del_cafeshop/features/shop/screens/cart/cart.dart';
import 'package:del_cafeshop/utils/constants/colors.dart';
import 'package:del_cafeshop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class CartCounterIcon extends StatelessWidget {
  const CartCounterIcon({
    super.key,
    this.iconColor,
    required this.onPressed,
    this.counterBgColor,
    this.counterTextColor,
  });

  final Color? iconColor;
  final VoidCallback onPressed;
  final Color? counterBgColor;
  final Color? counterTextColor;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    
    // Default colors based on theme
    final defaultIconColor = dark ? TColors.white : TColors.black;
    final defaultCounterBg = dark ? TColors.white : TColors.black;
    final defaultCounterTextColor = dark ? TColors.black : TColors.white;

    return Stack(
      children: [
        IconButton(
          onPressed: () => Get.to(() => CartScreen()),
          icon: Icon(Iconsax.shopping_bag, color: iconColor ?? defaultIconColor),
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: counterBgColor ?? defaultCounterBg,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                '2', // Replace with your actual cart count
                style: Theme.of(context).textTheme.labelLarge!.apply(
                  color: counterTextColor ?? defaultCounterTextColor,
                  fontSizeFactor: 0.8,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}