import 'package:del_cafeshop/common/widgets/appbar/appbar.dart';
import 'package:del_cafeshop/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:del_cafeshop/common/widgets/success_screen/success_screen.dart';
import 'package:del_cafeshop/features/shop/controlles/cart_controller.dart';
import 'package:del_cafeshop/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:del_cafeshop/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:del_cafeshop/features/shop/screens/checkout/widgets/build_payment_option.dart';
import 'package:del_cafeshop/features/shop/screens/payments/payment.dart';
import 'package:del_cafeshop/navigation_menu.dart';
import 'package:del_cafeshop/utils/constants/colors.dart';
import 'package:del_cafeshop/utils/constants/image_strings.dart';
import 'package:del_cafeshop/utils/constants/sizes.dart';
import 'package:del_cafeshop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String?> createTransaction({
  required String orderId,
  required int amount,
  required String customerName,
}) async {
  final url = Uri.parse('http://192.168.135.183:8000/admin/payment');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'orderId': orderId,
        'amount': amount,
        'customerName': customerName,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final snapToken = data['snapToken'];
      print('Snap Token: ${data['snapToken']}'); // Debug: tampilkan token
      return snapToken;
    } else {
      print('Gagal membuat transaksi: ${response.body}');
      return null;
    }
  } catch (e) {
    print('Error creating transaction: $e');
    return null;
  }
}

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  String _formatPrice(double price) {
    return 'Rp${price.toStringAsFixed(0).replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    )}';
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final cartController = Get.find<CartController>();

    return Scaffold(
      appBar: TAppbar(
        showBackArrow: true,
        title: Text('Order Summary', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: const SingleChildScrollView(
        padding:  EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            CartItems(showAddRemoveButtons: false),
             SizedBox(height: TSizes.spaceBtwSections),
            // ... bagian lain tetap sama
          ],
        ),
      ),
      bottomNavigationBar: Obx(() {
        final total = cartController.totalHarga;

        return Container(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          decoration: BoxDecoration(
            color: dark ? TColors.dark : TColors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () async {
              String? token = await createTransaction(
                orderId: 'ORDER-${DateTime.now().millisecondsSinceEpoch}',
                amount: total.toInt(),
                customerName: 'Cowo Sonyaa',
              );

              if (token != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => PaymentPage(snapToken: token),
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Gagal memulai pembayaran')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange,
              padding: const EdgeInsets.symmetric(vertical: TSizes.sm),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Text('Bayar Sekarang (${_formatPrice(total)})'),
          ),
        );
      }),
    );
  }
}
