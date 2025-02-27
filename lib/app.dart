
import 'package:flutter/material.dart';

import 'app_router.dart';
import 'views/home_page.dart' show HomeScreen;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return 
    MaterialApp.router(
      debugShowCheckedModeBanner: false,  
         routerConfig: appRouter,
    );
  }
}

class ReadyAppScreen extends StatelessWidget {
  const ReadyAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,     
      home: HomeScreen(),
    );
  }
}

class GlobalErrorScreen extends StatelessWidget {
  final Object? error;
  final VoidCallback onRetry;

  const GlobalErrorScreen({super.key, this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("An error occurred!"),
            if (error != null) Text(error.toString()),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text("Retry"),
            ),
          ],
        ),
      ),
    );
  }
}