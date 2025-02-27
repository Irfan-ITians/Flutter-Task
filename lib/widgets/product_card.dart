import 'package:check/utilities/size_utilities.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

import '../models/product.dart';
import '../utilities/color.dart';
import 'custom_text.dart';
class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: InkWell(
        onTap: () {
     GoRouter.of(context).push('/product/${product.id}', extra: product);
   },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                 height: 160,
               width: 300, 
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12), 
                  child: Image.network(
                   product.thumbnail,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          width: double.infinity,
                          height: 160,
                          color: Colors.white,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.error, size: 40, color: Colors.red),
                  ),
                ),
              ),
            ),
        
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0,vertical: 3),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextWidget(text: product.title.length>15?'${product.title.substring(0, 15)}...':product.title,fontWeight: FontWeight.bold, fontSize: 16),
                      CustomTextWidget(text:"\$${product.price}",fontWeight: FontWeight.bold, fontSize: 16 )
                      
                    ],
                  ),

                 5.height,
                  Row(
                    children: [
                       CustomTextWidget(text:   product.rating.toString(),fontWeight: FontWeight.bold, ),
                      8.width,
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            Icons.star,
                            color: index < product.rating ? AppColor.orange : AppColor.greyColor,
                            size: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
              5.height,
               CustomTextWidget(text:  "By ${product.brand}",color:  AppColor.greyColor,),
                 
             5.height, 
          CustomTextWidget(text:  "In ${product.category}",color:  AppColor.bottomBackColor,),
                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
