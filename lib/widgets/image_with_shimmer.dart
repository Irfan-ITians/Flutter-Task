import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
Widget BuildImageWithShimmer(String imageUrl, double height) {
  return StatefulBuilder(
    builder: (context, setState) {
      bool isLoading = true;

      return Stack(
        children: [
          if (isLoading) 
            Positioned.fill(
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  color: Colors.white,
                ),
              ),
            ),
          Image.network(
            imageUrl,
            height: height,
            width: double.infinity,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                // Image is fully loaded, remove shimmer
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  setState(() {
                    isLoading = false;
                  });
                });
                return child;
              }
              return const SizedBox(); 
            },
            errorBuilder: (context, error, stackTrace) {
              return Center(
                child: Icon(Icons.image_not_supported, color: Colors.grey, size: height / 3),
              );
            },
          ),
        ],
      );
    },
  );
}
