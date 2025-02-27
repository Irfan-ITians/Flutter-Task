

import 'package:check/app.dart' show GlobalErrorScreen, ReadyAppScreen;
import 'package:check/initialization/views/initializer.dart';
import 'package:check/views/user_screen.dart';
import 'package:go_router/go_router.dart';

import 'models/product.dart';
import 'views/home_page.dart';
import 'views/product_detail_screen.dart';
import 'views/product_screen.dart';

// App Router Configuration
final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const InitialWrapper(),
    ),
    GoRoute(
      path: '/ready',
      builder: (context, state) => const ReadyAppScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
     GoRoute(
      path: '/products/:category', // Dynamic category parameter
      builder: (context, state) {
        final category = state.pathParameters['category']!;
        return ProductsScreen(selectedCategory: category);
      },
    ),
     GoRoute(
  path: '/product-detail',
  builder: (context, state) {
    final product = state.extra as Product; // Get the Product object
    return ProductDetailScreen(product: product);
  },
),
    GoRoute(
      path: '/user',
      builder: (context, state) => const UserScreen(),
    ),
    GoRoute(
  path: '/error',
  builder: (context, state) {
    final onRetry = state.extra as void Function()? ?? () => context.go('/');

    return GlobalErrorScreen(onRetry: onRetry);
  },
),

 GoRoute( 
      path: '/product/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        final product = state.extra as Product; // Extract product from extra

        return ProductDetailScreen(product: product);
      },
    )
  ],
);
