import 'package:check/app.dart' ;
import 'package:check/controller/category_provider.dart' ;
import 'package:check/controller/favorite_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/product_provider.dart';
import 'initialization/controllers/init_controller.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
         ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
       ChangeNotifierProvider(create: (_) => InitializationProvider(),
      ),
      ],
      child: const MyApp(),
    ),
  );
}