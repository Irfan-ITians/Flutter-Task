import 'package:check/utilities/size_utilities.dart';
import 'package:check/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart'; // Import shimmer package
import '../controller/favorite_provider.dart';
import '../models/product.dart';
import '../utilities/color.dart';
import '../utilities/string.dart';
import '../widgets/image_with_shimmer.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final isFav = favoriteProvider.isFavorite(product);

    return Scaffold(
      appBar: AppBar(
        title: CustomTextWidget(
          text: product.title,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image with Shimmer
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
                child: Card(
                  elevation: 0.2,
                  child: BuildImageWithShimmer(product.thumbnail, 250),
                ),
              ),
              16.height,
              Row(
                children: [
                  const CustomTextWidget(text: strings.p_detail, fontSize: 22, fontWeight: FontWeight.bold),
                  const Spacer(),
                  IconButton(
                    icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: isFav ? AppColor.red : null),
                    onPressed: () {
                      if (isFav) {
                        favoriteProvider.removeFromFavorites(product);
                      } else {
                        favoriteProvider.addToFavorites(product);
                      }
                    },
                  ),
                ],
              ),
              8.height,
              _buildDetailRow(strings.name, product.title),
              _buildDetailRow(strings.price, "\$${product.price}"),
              _buildDetailRow(strings.category, product.category),
              _buildDetailRow(strings.brand, product.brand),
              Row(
                children: [
                  const CustomTextWidget(text: strings.rating, fontSize: 16, fontWeight: FontWeight.bold),
                  CustomTextWidget(text: product.rating.toString(), fontSize: 16),
                  4.width,
                  const Icon(Icons.star, color: AppColor.amber, size: 18),
                ],
              ),
              4.height,
              _buildDetailRow(strings.stock, product.stock.toString()),
              8.height,
              const CustomTextWidget(text: strings.desc, fontSize: 16, fontWeight: FontWeight.bold),
              CustomTextWidget(text: product.description),
              16.height,
              CustomTextWidget(text: strings.gallery, fontSize: 18, fontWeight: FontWeight.bold),
              8.height,
             SizedBox(
  height: 400, 
  child: GridView.builder(
    physics: const BouncingScrollPhysics(), 
    itemCount: product.images.length,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
      childAspectRatio: 1,
    ),
    itemBuilder: (context, index) {
      return Padding(
        padding: EdgeInsets.only(
          top: index % 4 == 0 || index % 4 == 3 ? 15 : 0, // Move items up
          bottom: index % 4 == 1 || index % 4 == 2 ? 15 : 0, // Move items down
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: BuildImageWithShimmer(product.images[index], 180),
        ),
      );
    },
  ),
),

            ],
          ),
        ),
      ),
    );
  }

  // Build Row for Product Details
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          CustomTextWidget(text: label, fontSize: 16, fontWeight: FontWeight.bold),
          4.width,
          Expanded(child: CustomTextWidget(text: value, fontSize: 16)),
        ],
      ),
    );
  }


}
