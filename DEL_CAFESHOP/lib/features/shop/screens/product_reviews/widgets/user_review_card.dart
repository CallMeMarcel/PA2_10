import 'package:del_cafeshop/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:del_cafeshop/common/widgets/products/ratings/rating_indicator.dart';
import 'package:del_cafeshop/utils/constants/colors.dart';
import 'package:del_cafeshop/utils/constants/image_strings.dart';
import 'package:del_cafeshop/utils/constants/sizes.dart';
import 'package:del_cafeshop/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(backgroundImage: AssetImage(TImages.user)),
                const SizedBox(width:TSizes.spaceBtwItems,),
                Text('Anya Sparkle', style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ],
        ),
        const SizedBox(width: TSizes.spaceBtwItems,),



        /// Review
        Row(
          children: [
            const PRatingBarIndicator(rating: 4),
            const SizedBox(width: TSizes.spaceBtwItems,),
            Text('09 Nov 2005', style: Theme.of(context).textTheme.bodyMedium),

          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItems,),
        const ReadMoreText(
        'The user interface of the app is quite intuitive. I was able to navigate and make purchase seamlessly, Great job!',
        trimLines: 1,
        trimMode: TrimMode.Line,
        trimExpandedText: 'show less',
        trimCollapsedText: 'show more',
        moreStyle:  TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
        lessStyle:  TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems,),


        /// Company Review
        RoundedContainer(
          backgroundColor: dark ? TColors.darkGrey : TColors.grey,
          child: Padding(padding: EdgeInsets.all(TSizes.md),
          child:Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Cafe Shop', style: Theme.of(context).textTheme.titleMedium),
                  Text('09 Nov 2005', style: Theme.of(context).textTheme.bodyMedium,),
                   
                ],
              ),
                 const SizedBox(height: TSizes.spaceBtwItems,),
        const ReadMoreText(
        'The user interface of the app is quite intuitive. I was able to navigate and make purchase seamlessly, Great job!',
        trimLines: 1,
        trimMode: TrimMode.Line,
        trimExpandedText: 'show less',
        trimCollapsedText: 'show more',
        moreStyle:  TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
        lessStyle:  TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: TColors.primary),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems,),

            ],
          ) ,),
          
        )
      ],
    );
  }
}