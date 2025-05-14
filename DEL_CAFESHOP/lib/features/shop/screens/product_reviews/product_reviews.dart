import 'package:del_cafeshop/common/widgets/appbar/appbar.dart';
import 'package:del_cafeshop/common/widgets/products/ratings/rating_indicator.dart';
import 'package:del_cafeshop/features/shop/screens/product_reviews/widgets/rating_progress_indicator.dart';
import 'package:del_cafeshop/features/shop/screens/product_reviews/widgets/user_review_card.dart';
import 'package:del_cafeshop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class ProductReviewsScreen extends StatelessWidget {
  const ProductReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// AppBar
      appBar: const TAppbar(title: Text('Reviews & rating')),

      /// Body
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Description
            const Text(
              'Ratings and reviews are verified and are from people who use the same type of device that you use.',
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            /// Overall Ratings
            const OverallProductRating(),
            const PRatingBarIndicator(rating: 3.5),
            Text(
              '12,661',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            /// User Review List
            const UserReviewCard(),
            const SizedBox(height: TSizes.spaceBtwItems),
            const UserReviewCard(),
          ],
        ),
      ),
    );
  }
}
