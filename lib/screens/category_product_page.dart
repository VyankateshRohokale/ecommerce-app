import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CategoryProductPage extends StatelessWidget {
  final String categoryName;

  const CategoryProductPage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final textScaleFactor = mediaQuery.textScaler.scale(1.0);

    // Sample data for products in this category (similar to your existing product cards)
    final List<Map<String, String>> categoryProducts = [
      {
        'title': 'TMA-2 HD Wireless',
        'imageUrl': 'assets/images/headphone.jpg',
        'price': 'Rp. 1.500.000',
        'rating': '4.6',
        'reviews': '86 Reviews',
      },
      {
        'title': 'TMA-2 HD Wireless',
        'imageUrl': 'assets/images/headphone.jpg',
        'price': 'Rp. 1.500.000',
        'rating': '4.6',
        'reviews': '86 Reviews',
      },
      {
        'title': 'TMA-2 HD Wireless',
        'imageUrl': 'assets/images/headphone.jpg',
        'price': 'Rp. 1.500.000',
        'rating': '4.6',
        'reviews': '86 Reviews',
      },
      {
        'title': 'TMA-2 HD Wireless',
        'imageUrl': 'assets/images/headphone.jpg',
        'price': 'Rp. 1.500.000',
        'rating': '4.6',
        'reviews': '86 Reviews',
      },
      {
        'title': 'TMA-2 HD Wireless',
        'imageUrl': 'assets/images/headphone.jpg',
        'price': 'Rp. 1.500.000',
        'rating': '4.6',
        'reviews': '86 Reviews',
      },
      {
        'title': 'TMA-2 HD Wireless',
        'imageUrl': 'assets/images/headphone.jpg',
        'price': 'Rp. 1.500.000',
        'rating': '4.6',
        'reviews': '86 Reviews',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            context.pop(); // Go back to the previous screen (HomePage)
          },
        ),
        title: Text(
          categoryName, // Display the dynamic category name
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              debugPrint('Cart tapped from category page');
              context.go('/detail'); // Navigate to a generic detail screen or cart
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Input Field for Category Page
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(screenWidth * 0.025),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search Product Name',
                  hintStyle: TextStyle(color: Colors.grey[500], fontSize: screenWidth * 0.038 / textScaleFactor),
                  suffixIcon: Icon(Icons.search, color: Colors.grey, size: screenWidth * 0.055),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                ),
                style: TextStyle(fontSize: screenWidth * 0.04 / textScaleFactor),
                onSubmitted: (value) {
                  debugPrint('Category product search submitted: $value');
                  // Implement search logic for this category
                },
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: GridView.builder(
                shrinkWrap: true, // Important for nested scroll views
                physics: const NeverScrollableScrollPhysics(), // Disable GridView's own scrolling
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 items per row
                  crossAxisSpacing: screenWidth * 0.03, // Spacing between columns
                  mainAxisSpacing: screenHeight * 0.02, // Spacing between rows
                  childAspectRatio: 0.7, // Adjust as needed to fit content
                ),
                itemCount: categoryProducts.length,
                itemBuilder: (context, index) {
                  final product = categoryProducts[index];
                  return _buildProductCard(
                    context,
                    product['title']!,
                    product['imageUrl']!,
                    product['price']!,
                    product['rating']!,
                    product['reviews']!,
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  );
                },
              ),
            ),
          ),
          // Persistent bottom bar for Filter & Sorting
          _buildFilterSortingBar(screenWidth, screenHeight, textScaleFactor),
        ],
      ),
    );
  }

  // Helper method to build product cards (reused from other pages)
  Widget _buildProductCard(
      BuildContext context,
      String title,
      String imageUrl,
      String price,
      String rating,
      String reviews,
      double screenWidth,
      double screenHeight,
      double textScaleFactor) {
    return GestureDetector(
      onTap: () {
        // Example of go_router navigation to a product detail page
        context.push('/product_detail/product_${title.hashCode}', extra: {'productName': title, 'imageUrl': imageUrl, 'newPrice': price});
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(screenWidth * 0.025),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(screenWidth * 0.025)),
              child: Image.asset(
                imageUrl,
                height: screenWidth * 0.25, // Responsive height
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: screenWidth * 0.25,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: Icon(Icons.broken_image, color: Colors.grey[600]),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.02), // Responsive padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.035 / textScaleFactor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Text(
                    price,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold, fontSize: screenWidth * 0.035 / textScaleFactor),
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: screenWidth * 0.035),
                      Text(
                        rating,
                        style: TextStyle(fontSize: screenWidth * 0.03 / textScaleFactor, color: Colors.grey[700]),
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      Text(
                        '($reviews)',
                        style: TextStyle(fontSize: screenWidth * 0.03 / textScaleFactor, color: Colors.grey[500]),
                      ),
                      const Spacer(),
                      Icon(Icons.more_vert, color: Colors.grey, size: screenWidth * 0.05),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Persistent bottom bar with Filter & Sorting button
  Widget _buildFilterSortingBar(double screenWidth, double screenHeight, double textScaleFactor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.015),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -3), // Shadow at the top
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity, // Make the button fill the width
        child: ElevatedButton(
          onPressed: () {
            debugPrint('Filter & Sorting tapped');
            // Implement filter and sorting logic
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Blue background
            padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.025),
            ),
          ),
          child: Text(
            'Filter & Sorting',
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.04 / textScaleFactor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
