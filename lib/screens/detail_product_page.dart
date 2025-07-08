import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Keep go_router import if you plan to use context.pop()

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
    // Changed to local asset path to display the headphone image
    final String imageUrl = extra?['imageUrl'] ?? 'assets/images/headphone.jpg';
    final String newPrice = extra?['newPrice'] ?? 'N/A';

    return Scaffold(
      appBar: AppBar(
        // Re-adding background color and elevation for consistent AppBar style
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            context.pop(); // Navigate back
          },
        ),
        title: Text(
          productName,
          style: TextStyle(
            color: Colors.black, // Ensure text color is visible on white AppBar
            fontWeight: FontWeight.bold, // Keep bold for consistency
            fontSize: screenWidth * 0.05 / textScaleFactor,
          ),
        ),
        centerTitle: true, // Center the title
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(screenWidth * 0.04),
                // Changed back to Image.asset to load the local headphone image
                child: Image.asset(
                  imageUrl,
                  height: screenHeight * 0.3,
                  width: double.infinity,
                  fit: BoxFit.contain, // <--- Changed from BoxFit.cover to BoxFit.contain
                  // Added errorBuilder for robustness with local assets
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: screenHeight * 0.3,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.broken_image,
                        size: screenWidth * 0.2,
                        color: Colors.grey[600],
                      ),
                    );
                  },
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
