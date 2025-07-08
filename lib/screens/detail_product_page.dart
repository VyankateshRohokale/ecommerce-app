// lib/screens/detail_product_page.dart
import 'package:flutter/material.dart';

class DetailProductPage extends StatelessWidget { // Class name also corrected
  final String? productId;
  final Map<String, dynamic>? extra;

  const DetailProductPage({super.key, this.productId, this.extra});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final screenWidth = mediaQuery.size.width;
    final textScaleFactor = mediaQuery.textScaler.scale(1.0);

    final String productName = extra?['productName'] ?? 'Unknown Product';
    final String imageUrl = extra?['imageUrl'] ?? 'https://placehold.co/200x200/CCCCCC/000000?text=No+Image';
    final String newPrice = extra?['newPrice'] ?? 'N/A';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          productName,
          style: TextStyle(fontSize: screenWidth * 0.05 / textScaleFactor),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(screenWidth * 0.04),
                child: Image.network(
                  imageUrl,
                  height: screenHeight * 0.3,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                productName,
                style: TextStyle(
                  fontSize: screenWidth * 0.06 / textScaleFactor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                'Product ID: ${productId ?? 'N/A'}',
                style: TextStyle(
                  fontSize: screenWidth * 0.035 / textScaleFactor,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: screenHeight * 0.01),
              Text(
                newPrice,
                style: TextStyle(
                  fontSize: screenWidth * 0.055 / textScaleFactor,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                'Description:',
                style: TextStyle(
                  fontSize: screenWidth * 0.04 / textScaleFactor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: screenHeight * 0.005),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                style: TextStyle(fontSize: screenWidth * 0.035 / textScaleFactor),
              ),
              SizedBox(height: screenHeight * 0.03),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Added $productName to cart!')),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.08,
                      vertical: screenHeight * 0.02,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(screenWidth * 0.02),
                    ),
                  ),
                  child: Text(
                    'Add to Cart',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.045 / textScaleFactor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}