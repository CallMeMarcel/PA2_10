import 'package:del_cafeshop/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:del_cafeshop/common/widgets/layouts/grid_layout.dart';
import 'package:del_cafeshop/common/widgets/products/brand/brand_card.dart';
import 'package:del_cafeshop/common/widgets/texts/section_heading.dart';
import 'package:del_cafeshop/data/models/category.dart';
import 'package:del_cafeshop/data/services/category_services.dart';
import 'package:del_cafeshop/features/shop/screens/cart/cart.dart';
import 'package:del_cafeshop/features/shop/screens/store/widgets/category.dart';
import 'package:del_cafeshop/features/shop/screens/store/widgets/category_class.dart';
import 'package:del_cafeshop/utils/constants/colors.dart';
import 'package:del_cafeshop/utils/constants/sizes.dart';
import 'package:del_cafeshop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Tambahkan jika menggunakan GetX

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = THelperFunctions.isDarkMode(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Store', 
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () => Get.to(() => CartScreen()), // Navigasi ke Cart
            ),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              CategoryClass(isDark: isDark),

            ];
          },
          body: const TabBarView(
            children: [
              CategoryTab(),
            ],
          ),
        ),
      ),
    );
  }
}
