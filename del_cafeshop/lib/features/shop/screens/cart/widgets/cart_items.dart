import 'package:del_cafeshop/data/models/product.dart';
import 'package:del_cafeshop/features/shop/controlles/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:del_cafeshop/common/widgets/products/cart/add_remove_cart.dart';
import 'package:del_cafeshop/common/widgets/products/cart/cart_item.dart';
import 'package:del_cafeshop/common/widgets/texts/product_price_text.dart';
import 'package:del_cafeshop/utils/constants/sizes.dart';
import 'package:get/get.dart';

class CartItems extends StatelessWidget {
  const CartItems({super.key, this.showAddRemoveButtons = true});
  final bool showAddRemoveButtons;
  

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Obx(() {
      final items = cartController.cartItems;

      if (items.isEmpty) {
        return const Center(child: Text("Keranjang kosong"));
      }

      return SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            // Select All checkbox at the top
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
              child: Row(
                children: [
                  Checkbox(
                    value: cartController.isSelectAll.value,
                    onChanged: (value) {
                      cartController.toggleSelectAll(value, items);
                    },
                  ),
                  const SizedBox(width: TSizes.spaceBtwItems / 2),
                  Text(
                    'Pilih Semua',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: TSizes.sm),
                    child: Text(
                      'Total: ${_formatPrice(cartController.totalHarga)}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            
            // List of cart items with checkboxes
            ListView.separated(
              shrinkWrap: true, // Penting untuk nested ListView
              physics: const NeverScrollableScrollPhysics(), // Nonaktifkan scroll internal
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwSections),
              itemBuilder: (_, index) {
                final product = items[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: TSizes.sm),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Checkbox for selecting item
                      Padding(
                        padding: const EdgeInsets.only(top: TSizes.sm),
                        child: Checkbox(
                          value: cartController.selectedProducts.contains(product),
                          onChanged: (value) {
                            cartController.toggleItem(product);
                          },
                        ),
                      ),
                      const SizedBox(width: TSizes.spaceBtwItems / 2),
                      
                      // Product details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Menampilkan CartItem dengan data produk
                            CartItem(product: product),
                            if (showAddRemoveButtons) ...[
                              const SizedBox(height: TSizes.spaceBtwItems),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: TSizes.sm),
                                    child: ProductQuantityWithAddRemove(product: product),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: TSizes.sm),
                                    child: ProductPrice(
                                      price: _formatPrice(
                                        (product.price ?? 0.0) * product.quantity.value,

                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      );
    });
  }

  String _formatPrice(double price) {
    return 'Rp${price.toStringAsFixed(0).replaceAllMapped(
          RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]}.',
        )}';
  }
}