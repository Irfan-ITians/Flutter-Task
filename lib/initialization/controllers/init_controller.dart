import 'package:check/controller/product_provider.dart' show ProductProvider;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum InitialAppState {
  loading,
  initialized,
  error,
}

class InitializationProvider extends ChangeNotifier {
  InitialAppState appState = InitialAppState.loading;
  Object? error;
  final ProductProvider productProvider =ProductProvider();

  InitializationProvider() {
    initializeApp();
  }

  Future<void> initializeApp() async {
    try {
      appState = InitialAppState.loading;
    await  productProvider.fetchAllProducts();
    notifyListeners(); 
      appState = InitialAppState.initialized;
    } catch (e) {
      error = e;
      appState = InitialAppState.error;
    }
    notifyListeners();
  }
}
