import 'package:del_cafeshop/common/widgets/custom_shapes/containers/primary_header_controller.dart';
import 'package:del_cafeshop/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:del_cafeshop/common/widgets/layouts/grid_layout.dart';
import 'package:del_cafeshop/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:del_cafeshop/common/widgets/texts/section_heading.dart';
import 'package:del_cafeshop/data/models/product.dart';
import 'package:del_cafeshop/data/services/product_service.dart';
import 'package:del_cafeshop/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:del_cafeshop/features/shop/screens/home/widgets/home_category.dart';
import 'package:del_cafeshop/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:del_cafeshop/utils/constants/image_strings.dart';
import 'package:del_cafeshop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();
  List<Product> products = [];
  List<Product> filteredProducts = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchProducts();
    searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredProducts = products
          .where((product) => product.title.toLowerCase().contains(query))
          .toList();
    });
  }

  Future<void> _fetchProducts() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      final fetchedProducts = await ProductService.getProducts();
      setState(() {
        products = fetchedProducts;
        filteredProducts = fetchedProducts; // tampilkan semua saat awal
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderController(
              child: Column(
                children: [
                  const HomeAppBar(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  /// Search Container
                  SearchContainer(
                    text: 'Search in Store',
                    controller: searchController,
                  ),

                  const SizedBox(height: TSizes.spaceBtwSections),

                  Padding(
                    padding: const EdgeInsets.only(left: TSizes.defaultSpace),
                    child: Column(
                      children: const [
                        SectionHeading(
                          title: 'Popular Categories',
                          showActionButton: false,
                          textColor: Colors.white,
                        ),
                        SizedBox(height: TSizes.spaceBtwSections),
                        HomeCategory(),
                      ],
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),

            /// Body Content
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const PromoSlider(banners: [
                    TImages.promo1,
                    TImages.promo2,
                    TImages.promo3,
                  ]),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  SectionHeading(title: 'Popular Products', onPressed: () {}),

                  const SizedBox(height: TSizes.spaceBtwItems),

                  if (isLoading)
                    const Center(child: CircularProgressIndicator())
                  else if (errorMessage.isNotEmpty)
                    Column(
                      children: [
                        Text('Error: $errorMessage'),
                        ElevatedButton(
                          onPressed: _fetchProducts,
                          child: const Text('Retry'),
                        ),
                      ],
                    )
                  else if (filteredProducts.isEmpty)
                    const Text('No products found.')
                  else
                    GridLayout(
                      itemCount: filteredProducts.length > 4
                          ? 4
                          : filteredProducts.length,
                      itemBuilder: (_, index) => ProductCardVertical(
                        product: filteredProducts[index],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
