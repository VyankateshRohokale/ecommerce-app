// lib/providers/app_data_provider.dart
import 'package:flutter/material.dart';

/// A simple ChangeNotifier class to manage application-wide data and state.
///
/// This serves as an example for how you can use the Provider package
/// for state management. You can extend it with more properties
/// and methods as your application grows.
class AppDataProvider extends ChangeNotifier {
  // Example state: Controls whether a hypothetical sidebar is open or closed.
  bool _isSidebarOpen = false;

  /// Getter to access the current sidebar state.
  bool get isSidebarOpen => _isSidebarOpen;

  /// Toggles the sidebar state and notifies listeners.
  void toggleSidebar() {
    _isSidebarOpen = !_isSidebarOpen;
    notifyListeners(); // This tells any widgets listening to this provider to rebuild.
  }

  // --- You can add more application-level data and logic here ---

  // Example: User authentication status
  // bool _isAuthenticated = false;
  // bool get isAuthenticated => _isAuthenticated;
  // void login() { _isAuthenticated = true; notifyListeners(); }
  // void logout() { _isAuthenticated = false; notifyListeners(); }

  // Example: Shopping cart items (simplified)
  // List<String> _cartItems = [];
  // List<String> get cartItems => _cartItems;
  // void addItemToCart(String item) {
  //   _cartItems.add(item);
  //   notifyListeners();
  // }
  // void removeItemFromCart(String item) {
  //   _cartItems.remove(item);
  //   notifyListeners();
  // }
}