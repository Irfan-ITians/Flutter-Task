import 'package:check/utilities/size_utilities.dart';
import 'package:check/utilities/string.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/product_provider.dart';
import '../models/product.dart' show Product;
import '../utilities/color.dart';
import '../widgets/custom_text.dart' show CustomTextWidget;
import '../widgets/product_card.dart';
import '../widgets/search_bar.dart';
import '../widgets/shimmer_product_card.dart';
import 'product_detail_screen.dart';
import 'package:shimmer/shimmer.dart';

class ProductsScreen extends StatefulWidget {
  final String? selectedCategory; 

  const ProductsScreen({Key? key, this.selectedCategory}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String _searchQuery = '';
 bool _isCategoryView = false; // Toggling condition

@override
  void initState() {
    super.initState();
    switchcase();
  }
 
  Future<void> switchcase()async{
final productProvider = Provider.of<ProductProvider>(context, listen: false);
    
    if (widget.selectedCategory != null) {
      _isCategoryView = true;
     await productProvider.fetchProductsByCategory(widget.selectedCategory!);
    } else {
      _isCategoryView = false;
     await productProvider.fetchAllProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
     final productProvider = Provider.of<ProductProvider>(context);
    final products = _isCategoryView
        ? productProvider.categoryProducts
        : productProvider.filteredProducts(_searchQuery);

    return Scaffold(
     appBar: AppBar(
      backgroundColor: AppColor.whiteColor,
      centerTitle: true,
     title: CustomTextWidget(
         text: strings.products,
         fontWeight:  FontWeight.w600,
          ) ,
     
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
         padding: const EdgeInsets.symmetric(horizontal: 16, ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 7.0),
              child: CustomTextWidget(text: '${products.length} ${strings.found}',color: Colors.grey),
            ),
          10.height,
            Expanded(
              child: productProvider.isLoading || productProvider.isCategoryProductsLoading
                ? ListView.builder(
                itemCount: 6,
                itemBuilder: (_, index) => const ShimmerProductCard(),
              )
                : ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (_, index) {
                      final product = products[index];
                      return ProductCard(product: product);
                    },
                  ),
            ),
        ]),
      ),
    );
  }
}



