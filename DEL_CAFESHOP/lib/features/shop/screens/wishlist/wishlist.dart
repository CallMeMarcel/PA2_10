import 'package:del_cafeshop/common/widgets/appbar/appbar.dart';
import 'package:del_cafeshop/common/widgets/icons/circular_icon.dart';
import 'package:del_cafeshop/common/widgets/layouts/grid_layout.dart';
import 'package:del_cafeshop/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:del_cafeshop/data/models/product.dart';
import 'package:del_cafeshop/data/services/wishlist_service.dart';
import 'package:del_cafeshop/features/shop/controlles/whistlist_controller.dart';
import 'package:del_cafeshop/features/shop/screens/home/home.dart';
import 'package:del_cafeshop/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

 // Pastikan ini sesuai path kamu

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final wishlistController = Get.find<WishlistController>();

    return Scaffold(
      appBar: TAppbar(
        title: Text('Wishlist', style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          CircularIcon(
            icon: Iconsax.add,
            onPressed: () => Get.to(const HomeScreen()),
          ),
        ],
      ),
      body: Obx(() {
        final allProducts = wishlistController.wishlistItems;
        
        if (allProducts.isEmpty) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(TSizes.defaultSpace),
              child: Text('Tidak ada produk favorit'),
            ),
          );
        }
        

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: GridLayout(
              itemCount: allProducts.length,
              itemBuilder: (_, index) => ProductCardVertical(
                product: allProducts[index],
                isWishlisted: true,
                onWishlistPressed: () {
                  wishlistController.toggleWishlist(allProducts[index]);
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}


// class FavoriteScreen extends StatefulWidget {
//   const FavoriteScreen({super.key});

//   @override
//   State<FavoriteScreen> createState() => _FavoriteScreenState();
// }

// class _FavoriteScreenState extends State<FavoriteScreen> {
//   List<Product> products = [];
//   bool isLoading = true;
//   String errorMessage = '';

//   @override
//   void initState() {
//     super.initState();
//     _fetchWishlist();
//   }

//   Future<void> _fetchWishlist() async {
//     try {
//       final wishlist = await WishlistService.getWishlist();
//       setState(() {
//         products = wishlist;
//         errorMessage = '';
//       });
//     } catch (e) {
//       setState(() {
//         errorMessage = e.toString();
//       });
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: TAppbar(
//         title: Text('Wishlist', style: Theme.of(context).textTheme.headlineMedium),
//         actions: [
//           CircularIcon(icon: Iconsax.add, onPressed: () => Get.to(const HomeScreen())),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(TSizes.defaultSpace),
//         child: isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : errorMessage.isNotEmpty
//                 ? Column(
//                     children: [
//                       Text('Error: $errorMessage'),
//                       ElevatedButton(
//                         onPressed: _fetchWishlist,
//                         child: const Text('Retry'),
//                       ),
//                     ],
//                   )
//                 : products.isEmpty
//                     ? const Text('Tidak ada produk favorit')
//                     : GridLayout(
//                         itemCount: products.length,
//                         itemBuilder: (_, index) => ProductCardVertical(
//                           product: products[index],
//                           isWishlisted: true,
//                           onWishlistPressed: () async {
//                             await WishlistService.toggleWishlist(products[index].id);
//                             _fetchWishlist(); // refresh data setelah toggle
//                           },
//                         ),
//                       ),
//       ),
//     );
//   }
// }
