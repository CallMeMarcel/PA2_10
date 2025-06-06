import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:del_cafeshop/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:del_cafeshop/utils/constants/colors.dart';
import 'package:del_cafeshop/utils/constants/sizes.dart';
import 'package:del_cafeshop/utils/helpers/helper_functions.dart';

class OrderListItems extends StatelessWidget {
  const OrderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return ListView.separated(
      shrinkWrap: true,
      itemCount: 10,
      separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwItems),
      itemBuilder: (_, index) => RoundedContainer(
        showBorder: true,
        padding: const EdgeInsets.all(TSizes.md),
        backgroundColor: dark ? TColors.dark : TColors.light,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// Row 1 - Status
            Row(
              children: [
                const Icon(Iconsax.ship),
                const SizedBox(width: TSizes.spaceBtwItems / 2),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Processing',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .apply(color: TColors.primary, fontWeightDelta: 1),
                      ),
                      Text(
                        '09 Nov 2024',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Iconsax.arrow_right_34, size: TSizes.iconSm),
                ),
              ],
            ),

            const SizedBox(height: TSizes.spaceBtwItems),

            /// Row 2 - Detail
            Row(
              children: [
                /// Order ID
                const Icon(Iconsax.tag),
                const SizedBox(width: TSizes.spaceBtwItems / 2),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order', style: Theme.of(context).textTheme.labelMedium),
                      Text('[#323034]', style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ),

                /// Shipping Date
                const Icon(Iconsax.calendar),
                const SizedBox(width: TSizes.spaceBtwItems / 2),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Shipping Date', style: Theme.of(context).textTheme.labelMedium),
                      Text('4 April 2025', style: Theme.of(context).textTheme.titleMedium),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
