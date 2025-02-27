import 'package:check/controller/category_provider.dart' show CategoryProvider;
import 'package:check/utilities/color.dart';
import 'package:check/utilities/size_utilities.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../utilities/category_images.dart';
import '../utilities/string.dart';
import '../widgets/custom_text.dart';
import '../widgets/search_bar.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String _searchQuery = '';


  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<CategoryProvider>(context, listen: false).fetchCategories());
    categoryImages;
  }


  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final categories = categoryProvider.filteredCategories(_searchQuery);

    return Scaffold(
      appBar: AppBar(
        title:const CustomTextWidget(
         text: strings.categories,
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
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 7.0),
              child: CustomTextWidget(text: '${categories.length} ${strings.found}',color: AppColor.greyColor, fontSize: 14),
            ),
            10.height,
            Expanded(
              child: categoryProvider.isCategoryLoading
                  ? _buildShimmerGrid()
                  : GridView.builder(
                      itemCount: categories.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 1, 
                      ),
                      itemBuilder: (_, index) {
                        final category = categories[index];
                      final categoryImage = categoryImages[category.slug] ;

                        return GestureDetector(
                          onTap: () {
                           context.push('/products/${category.slug}');
                            },

                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image:  DecorationImage(
                                      image: NetworkImage(categoryImage!),
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.black.withOpacity(0.4), // Dark overlay
                              ),
                              alignment: Alignment.bottomLeft,
                              padding: const EdgeInsets.only(left: 15.0,bottom: 15),
                              child: CustomTextWidget(text: category.name,color: AppColor.whiteColor,fontWeight: FontWeight.bold,fontSize: 16,),
                              
                            ),
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
   Widget _buildShimmerGrid() {
    return GridView.builder(
      itemCount: 6, // Temporary loading skeletons
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemBuilder: (_, index) => Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

}