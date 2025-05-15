import 'package:del_cafeshop/data/models/category.dart';
import 'package:del_cafeshop/data/services/category_services.dart';
import 'package:flutter/material.dart';
import 'package:del_cafeshop/common/widgets/layouts/grid_layout.dart';
import 'package:del_cafeshop/common/widgets/products/brand/brand_show_case.dart';
import 'package:del_cafeshop/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:del_cafeshop/common/widgets/texts/section_heading.dart';
// import 'package:del_cafeshop/utils/constants/image_strings.dart';
import 'package:del_cafeshop/utils/constants/sizes.dart';

import 'package:del_cafeshop/data/models/product.dart';
import 'package:del_cafeshop/data/services/product_service.dart';

class CategoryTab extends StatefulWidget {
  const CategoryTab({super.key});

  @override
  State<CategoryTab> createState() => _CategoryTabState();
}

class _CategoryTabState extends State<CategoryTab> {
  Future<Map<Category, List<Product>>>? groupedProducts;
  List<Product> allProducts = [];

  @override
  void initState() {
    super.initState();
    groupedProducts = _getGroupedProductsByCategory();
  }

  Future<Map<Category, List<Product>>> _getGroupedProductsByCategory() async {
    final categories = await CategoryService.fetchCategories();
    final products = await ProductService.getProducts();

    // Simpan semua produk ke allProducts
    allProducts = products;

    Map<Category, List<Product>> grouped = {};
    for (var category in categories) {
      grouped[category] = products.where((p) => p.categoryId == category.id).toList();
    }

    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    if (groupedProducts == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return FutureBuilder<Map<Category, List<Product>>>(
      future: groupedProducts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No categories or products found.');
        }

        final groupedData = snapshot.data!;
        final filteredProducts = allProducts.take(100).toList(); // Contoh ambil 4 produk pertama

        return ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  ...groupedData.entries.map((entry) {
                    final category = entry.key;
                    final products = entry.value;
                    final imagePaths = products
                        .where((p) => p.image.isNotEmpty)
                        .map((p) => p.image)
                        .toList();

                    return BrandShowCase(images: imagePaths, category: category);
                  }).toList(),

                  const SizedBox(height: TSizes.spaceBtwItems),
                  SectionHeading(title: 'You might like', onPressed: () {}),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  GridLayout(
                    itemCount: filteredProducts.length,
                    itemBuilder: (_, index) => ProductCardVertical(
                      product: filteredProducts[index],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
