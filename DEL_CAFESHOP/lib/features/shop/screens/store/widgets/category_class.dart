import 'package:del_cafeshop/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:del_cafeshop/common/widgets/layouts/grid_layout.dart';
import 'package:del_cafeshop/common/widgets/products/brand/brand_card.dart';
// import 'package:del_cafeshop/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:del_cafeshop/common/widgets/texts/section_heading.dart';
import 'package:del_cafeshop/data/models/category.dart';
// import 'package:del_cafeshop/data/models/product.dart';
import 'package:del_cafeshop/data/services/category_services.dart';
// import 'package:del_cafeshop/data/services/product_service.dart';
import 'package:del_cafeshop/utils/constants/colors.dart';
import 'package:del_cafeshop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class CategoryClass extends StatelessWidget {
  const CategoryClass({super.key, required this.isDark});

  final bool isDark;

 @override
Widget build(BuildContext context) {
  return FutureBuilder<List<Category>>(
    future: CategoryService.fetchCategories(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
      } else if (snapshot.hasError) {
        return SliverToBoxAdapter(child: Center(child: Text('Error: ${snapshot.error}')));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const SliverToBoxAdapter(child: Center(child: Text('Tidak ada kategori.')));
      }

      final categories = snapshot.data!;

      return DefaultTabController(
        length: categories.length,
        child: SliverAppBar(
          automaticallyImplyLeading: false,
          pinned: true,
          floating: true,
          backgroundColor: isDark ? TColors.black : TColors.white,
          expandedHeight: 440,
          flexibleSpace: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                const SizedBox(height: TSizes.spaceBtwItems),
                const SearchContainer(text: 'Search in Store'),
                const SizedBox(height: TSizes.spaceBtwSections),
                SectionHeading(
                  title: 'Featured Food & Drink',
                  showActionButton: true,
                  onPressed: () {},
                ),
                const SizedBox(height: TSizes.spaceBtwItems / 1.5),
                GridLayout(
                  itemCount: categories.length,
                  mainAxisExtent: 80,
                  itemBuilder: (_, index) {
                    final category = categories[index];
                    return BrandCard(
                      showBorder: false,
                      category: category,
                    );
                  },
                ),
              ],
            ),
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48),
            child: TabBar(
              isScrollable: true,
              tabs: categories.map((cat) => Tab(child: Text(cat.name))).toList(),
            ),
          ),
        ),
      );
    },
  );
}
}