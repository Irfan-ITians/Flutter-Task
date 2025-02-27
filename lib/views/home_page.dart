import 'package:check/utilities/size_utilities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controller/category_provider.dart';
import '../controller/product_provider.dart';
import '../utilities/color.dart';
import '../utilities/string.dart';
import 'favorite_screen.dart';
import 'product_screen.dart';
import 'category_screen.dart';
import 'user_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    UserScreen(),
  ];

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(child: _pages[_currentIndex]),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColor.bottomBackColor,
        selectedItemColor: AppColor.whiteColor,
        unselectedItemColor: AppColor.whiteColor.withOpacity(0.6), // Slight fade for unselected items
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
        },
        items: List.generate(4, (index) {
          bool isSelected = _currentIndex == index;

          return 
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: isSelected ? AppColor.whiteColor.withOpacity(0.2) : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(_getIcon(index), color: isSelected ? AppColor.whiteColor.withOpacity(0.9) : AppColor.whiteColor),
                4.height,
                  Text(
                    _getLabel(index),
                    style: TextStyle(
                      color: isSelected ? AppColor.whiteColor.withOpacity(0.9) : AppColor.whiteColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            label: '', // Hide default label
          );
        }),
      ),
    );
  }

  IconData _getIcon(int index) {
     List<IconData> icons = [
      Icons.storefront_outlined, 
      Icons.grid_view,
      Icons.favorite_outline,
      Icons.person_outline, 
    ];
    return icons[index];
  }

  String _getLabel(int index) {
    List<String> labels = [strings.products, strings.categories, strings.favorite, strings.user];
    return labels[index];
  }
}
