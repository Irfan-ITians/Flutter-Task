import 'package:check/utilities/size_utilities.dart';
import 'package:check/widgets/custom_text.dart' show CustomTextWidget;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../controller/favorite_provider.dart';
import '../utilities/color.dart';
import '../utilities/string.dart';
import '../widgets/search_bar.dart';
import 'product_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final favorites = favoriteProvider.favorites
        .where((product) => product.title.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
       appBar: AppBar(
        title:
          CustomTextWidget(
         text: strings.favorite,
         fontWeight:  FontWeight.w600,
          ) ,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: SearchBarWidget(
            onSearchChanged: (query) {
              setState(() {
                _searchQuery = query;
              });
            },
          ),
        ),
      ),
      
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextWidget(text: '${favorites.length} ${strings.found}',color: AppColor.greyColor,),
            10.height,
            Expanded(
              child: favorites.isEmpty
                  ? const Center(child: CustomTextWidget(text: strings.no_fav))
                  : ListView.builder(
                      itemCount: favorites.length,
                      itemBuilder: (_, index) {
                        final product = favorites[index];

                        return Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(10),
                            leading:
                           SizedBox(
                            width: 80, 
                            height: 80, 
                          child: CircleAvatar(
                              radius: 40, 
                           backgroundImage: NetworkImage(product.thumbnail),
                             ),
                              ),

                            title:CustomTextWidget(text:product.title.length > 10 ? '${product.title.substring(0, 10)}...' : product.title,fontWeight: FontWeight.bold ),
                             
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomTextWidget(text:'\$${product.price}',fontWeight: FontWeight.bold ),
                                Row(
                                  children:  [
                                    Icon(Icons.star, color: AppColor.amber, size: 16),
                                    Icon(Icons.star, color: AppColor.amber, size: 16),
                                    Icon(Icons.star, color: AppColor.amber, size: 16),
                                    Icon(Icons.star, color: AppColor.amber, size: 16),
                                    Icon(Icons.star_half, color:AppColor.amber, size: 16),
                                    4.width,
                                    CustomTextWidget(text: strings.point,fontWeight: FontWeight.bold,),
                                  ],
                                ),
                              ],
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.favorite, color: AppColor.red),
                              onPressed: () {
                                favoriteProvider.removeFromFavorites(product);
                              },
                            ),
                            onTap: () {
                              context.push('/product-detail', extra: product);
                            },

                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
