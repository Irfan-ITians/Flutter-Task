import 'package:check/app.dart';
import 'package:check/initialization/controllers/init_controller.dart';
import 'package:check/initialization/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class InitialWrapper extends StatelessWidget {
  const InitialWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.select<InitializationProvider, InitialAppState>(
      (provider) => provider.appState,
    );

    switch (appState) {
      case InitialAppState.loading:
        return const SplashScreen();
      case InitialAppState.initialized:
        return const ReadyAppScreen();
      case InitialAppState.error:
        return Consumer<InitializationProvider>(
          builder: (context, initProvider, _) => GlobalErrorScreen(
            error: initProvider.error,
            onRetry: initProvider.initializeApp,
          ),
        );
    }
  }
}

/*
class InitialWrapper extends StatelessWidget {
  const InitialWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<InitializationProvider>(
      builder: (context, initProvider, child) {
        switch (initProvider.appState) {
          case InitialAppState.loading:
            return const SplashScreen();
          case InitialAppState.initialized:
            return const ReadyAppScreen();
          case InitialAppState.error:
            return GlobalErrorScreen(
              error: initProvider.error,
              onRetry: initProvider.initializeApp,
            );
        }
      },
    );
  }
}
*/