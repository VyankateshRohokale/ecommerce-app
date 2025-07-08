import 'package:flutter/foundation.dart';
import 'dart:collection'; // For UnmodifiableSetView

class FavoriteProvider with ChangeNotifier {
  // Private set to store IDs of favorited products
  final Set<String> _favoriteProductIds = {};

  // Public getter to check if a product is favorited
  bool isFavorite(String productId) {
    return _favoriteProductIds.contains(productId);
  }

  // Method to toggle the favorite status of a product
  void toggleFavorite(String productId) {
    if (_favoriteProductIds.contains(productId)) {
      _favoriteProductIds.remove(productId);
    } else {
      _favoriteProductIds.add(productId);
    }
    notifyListeners(); // Notify listeners that the state has changed
  }

  // Public getter to access the set of favorite product IDs (unmodifiable)
  Set<String> get favoriteProductIds => UnmodifiableSetView(_favoriteProductIds);
}
