import 'package:del_cafeshop/common/widgets/appbar/appbar.dart';
import 'package:del_cafeshop/data/models/product.dart';
import 'package:del_cafeshop/features/shop/controlles/cart_controller.dart';
import 'package:del_cafeshop/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:del_cafeshop/features/shop/screens/checkout/checkout.dart';
import 'package:del_cafeshop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  CartScreen({super.key});
  final cartController = Get.put(CartController());
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title: Text('Cart', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            // Menambahkan CartItems yang bisa memanfaatkan ruang yang tersisa
            Expanded(
              child: Obx(() {
                if (cartController.cartItems.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.shopping_cart_outlined, size: 64),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        Text('Your cart is empty', 
                             style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        ElevatedButton(
                          onPressed: () => Get.back(),
                          child: const Text('Continue Shopping'),
                        ),
                      ],
                    ),
                  );
                }
                return const CartItems();
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() {
        if (cartController.cartItems.isEmpty) return const SizedBox.shrink();
        
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: TSizes.defaultSpace,
            vertical: TSizes.md,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  ProductPrice(
                    price: _formatPrice(cartController.totalHarga), // Removed .value here
                    isLarge: true,
                  ),
                ],
              ),
             SizedBox(
              width: 150,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => const CheckoutScreen());
                },
                child: const Text('Checkout'),
              ),
            ),

            ],
          ),
        );
      }),
    );
  }

  String _formatPrice(double price) {
    return 'Rp${price.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        )}';
  }
}

class ProductPrice extends StatelessWidget {
  final String price;
  final bool isLarge;

  const ProductPrice({
    super.key,
    required this.price,
    this.isLarge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      price,
      style: isLarge
          ? Theme.of(context).textTheme.headlineSmall
          : Theme.of(context).textTheme.titleMedium,
    );
  }
}