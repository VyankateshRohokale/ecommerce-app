// lib/screens/detail_product_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DetailProductPage extends StatelessWidget {
  final String? productId; // To receive product ID if passed
  final Map<String, dynamic>? extra; // To receive extra data like product name, image, price

  const DetailProductPage({super.key, this.productId, this.extra});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final textScaleFactor = mediaQuery.textScaler.scale(1.0);

    // Use data from 'extra' if available, otherwise use static placeholders
    final String productName = extra?['productName'] ?? 'TMA-2HD Wireless';
    final String productImageUrl = extra?['imageUrl'] ?? 'assets/images/headphone.jpg'; // Default image
    final String productPrice = extra?['newPrice'] ?? 'Rp 1.500.000';

    // Sample data for reviews
    final List<Map<String, String>> reviews = [
      {
        'name': 'Yelena Belova',
        'rating': '4.6',
        'time': '2 Minggu yang lalu',
        'comment': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      },
      {
        'name': 'Stephen Strange',
        'rating': '4.6',
        'time': '1 Bulan yang lalu',
        'comment': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      },
      {
        'name': 'Peter Parker',
        'rating': '4.6',
        'time': '2 Bulan yang lalu',
        'comment': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      },
    ];

    // Sample data for "Featured Product" (similar to HomePage and SearchPage)
    final List<Map<String, String>> featuredProducts = [
      {
        'title': 'TMA-2 HD Wireless',
        'imageUrl': 'assets/images/headphone.jpg', // Changed to local asset
        'price': 'Rp. 1.500.000',
        'rating': '4.6',
        'reviews': '86 Reviews',
      },
      {
        'title': 'TMA-2 HD Wireless',
        'imageUrl': 'assets/images/headphone.jpg', // Changed to local asset
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
            context.pop(); // Go back to the previous screen
          },
        ),
        title: Text(
          'Detail Product',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: () {
              debugPrint('Share product tapped');
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              debugPrint('Cart tapped');
              context.go('/detail'); // Navigate to a generic detail screen or cart
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(screenWidth * 0.03),
                    child: Image.asset( // Now using Image.asset for local image
                      productImageUrl, // Use dynamic image URL, which defaults to 'assets/images/headphone.jpg'
                      width: double.infinity,
                      height: screenHeight * 0.3,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: double.infinity,
                          height: screenHeight * 0.3,
                          color: Colors.grey[300],
                          child: Icon(Icons.broken_image, color: Colors.grey[600], size: screenWidth * 0.1),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: screenHeight * 0.01,
                    right: screenWidth * 0.03,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenHeight * 0.005),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      ),
                      child: Text(
                        '1/5 Foto',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.03 / textScaleFactor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Product Name and Price
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Text(
                productName,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.06 / textScaleFactor,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.005),
              child: Text(
                productPrice,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.05 / textScaleFactor,
                  color: Colors.red,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.amber, size: screenWidth * 0.04),
                  Text(
                    '4.6',
                    style: TextStyle(fontSize: screenWidth * 0.035 / textScaleFactor, color: Colors.grey[700]),
                  ),
                  SizedBox(width: screenWidth * 0.01),
                  Text(
                    '86 Reviews',
                    style: TextStyle(fontSize: screenWidth * 0.035 / textScaleFactor, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02),

            // Shop Information
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Container(
                padding: EdgeInsets.all(screenWidth * 0.03),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: screenWidth * 0.06,
                      backgroundImage: const NetworkImage('https://placehold.co/100x100/CCCCCC/000000?text=Shop'), // Placeholder for shop logo
                    ),
                    SizedBox(width: screenWidth * 0.03),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Shop Larson Electronic',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.04 / textScaleFactor,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                'Official Store',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: screenWidth * 0.035 / textScaleFactor,
                                ),
                              ),
                              SizedBox(width: screenWidth * 0.01),
                              Icon(Icons.verified, color: Colors.blue, size: screenWidth * 0.04),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, color: Colors.grey, size: screenWidth * 0.04),
                  ],
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),

            // Product Description
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Text(
                'Description Product',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.045 / textScaleFactor,
                  color: Colors.black,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.01),
              child: Text(
                '''The speaker unit contains a diaphragm that is precision-grown from NAC Audio bio-cellulose, making it stiffer, lighter and stronger than regular PET speaker units, and allowing the sound-producing diaphragm to vibrate without the levels of distortion found in other speakers.

The speaker unit contains a diaphragm that is precision-grown from NAC Audio bio-cellulose, making it stiffer, lighter and stronger than regular PET speaker units, and allowing the sound-producing diaphragm to vibrate without the levels of distortion found in other speakers.

The speaker unit contains a diaphragm that is precision-grown from NAC Audio bio-cellulose, and allowing the sound-producing diaphragm to vibrate without the levels of distortion found in other speakers.

The speaker unit contains a diaphragm that is precision-grown from NAC Audio bio-cellulose, making it stiffer, lighter and stronger than regular PET speaker units, and allowing the sound-producing diaphragm to vibrate without the levels of distortion found in other speakers.

The speaker unit contains a diaphragm that is precision-grown from NAC Audio bio-cellulose, making it stiffer, lighter and stronger than regular PET speaker units, and allowing the sound-producing diaphragm to vibrate without the levels of distortion found in other speakers.
                ''',
                style: TextStyle(
                  fontSize: screenWidth * 0.038 / textScaleFactor,
                  height: 1.5,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: screenHeight * 0.02),

            // Review Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Review (${reviews.length})',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.045 / textScaleFactor,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: screenWidth * 0.04),
                      Text(
                        '4.6',
                        style: TextStyle(fontSize: screenWidth * 0.035 / textScaleFactor, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            Column(
              children: reviews.map((review) {
                return _buildReviewItem(
                  review['name']!,
                  review['rating']!,
                  review['time']!,
                  review['comment']!,
                  screenWidth,
                  screenHeight,
                  textScaleFactor,
                );
              }).toList(),
            ),
            SizedBox(height: screenHeight * 0.02),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  debugPrint('See All Review tapped');
                  // context.go('/all_reviews'); // Example navigation
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.blue), // Blue border
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1, vertical: screenHeight * 0.015),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.025),
                  ),
                ),
                child: Text(
                  'See All Review',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: screenWidth * 0.04 / textScaleFactor),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.03),

            // Featured Product Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.015),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Featured Product',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.045 / textScaleFactor,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      debugPrint('See All Featured Products tapped');
                      // context.go('/featured_products'); // Example navigation
                    },
                    child: Text(
                      'See All',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: screenWidth * 0.035 / textScaleFactor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: screenHeight * 0.3, // Responsive height for horizontal list
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                itemCount: featuredProducts.length,
                itemBuilder: (context, index) {
                  final product = featuredProducts[index];
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
            SizedBox(height: screenHeight * 0.1), // Extra space for floating action buttons

          ],
        ),
      ),
      bottomSheet: _buildPersistentBottomBar(screenWidth, screenHeight, textScaleFactor),
    );
  }

  // Helper method to build individual review items
  Widget _buildReviewItem(String name, String rating, String time, String comment,
      double screenWidth, double screenHeight, double textScaleFactor) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.01),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: screenWidth * 0.05,
                backgroundImage: NetworkImage('https://placehold.co/100x100/CCCCCC/000000?text=${name.substring(0, 1)}'), // Placeholder avatar
              ),
              SizedBox(width: screenWidth * 0.02),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: screenWidth * 0.04 / textScaleFactor,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: screenWidth * 0.035),
                      Text(
                        rating,
                        style: TextStyle(fontSize: screenWidth * 0.03 / textScaleFactor, color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ],
              ),
              const Spacer(),
              Text(
                time,
                style: TextStyle(
                  color: Colors.grey[500],
                  fontSize: screenWidth * 0.03 / textScaleFactor,
                ),
              ),
            ],
          ),
          SizedBox(height: screenHeight * 0.01),
          Text(
            comment,
            style: TextStyle(
              fontSize: screenWidth * 0.038 / textScaleFactor,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build product cards (reused from HomePage and SearchPage)
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
        context.go('/product_detail/product_${title.hashCode}', extra: {'productName': title, 'imageUrl': imageUrl, 'newPrice': price});
      },
      child: Container(
        width: screenWidth * 0.4, // Responsive width
        margin: EdgeInsets.only(right: screenWidth * 0.04), // Responsive margin
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(screenWidth * 0.025), // Responsive border radius
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
              child: Image.asset( // Changed from Image.network to Image.asset
                imageUrl, // This will now be 'assets/images/headphone.jpg'
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

  // Persistent bottom bar with Add and Favorite buttons
  Widget _buildPersistentBottomBar(double screenWidth, double screenHeight, double textScaleFactor) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
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
      child: Row(
        children: [
          // Add button
          Expanded(
            flex: 3,
            child: ElevatedButton.icon(
              onPressed: () {
                debugPrint('Add button tapped');
                // Implement add to cart logic
              },
              icon: Icon(Icons.add, color: Colors.white, size: screenWidth * 0.05),
              label: Text(
                'Added', // Changed from 'Add' to 'Added' as per image
                style: TextStyle(
                  color: Colors.white,
                  fontSize: screenWidth * 0.04 / textScaleFactor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.025),
                ),
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.03),
          // Favorite button
          Expanded(
            flex: 1,
            child: ElevatedButton(
              onPressed: () {
                debugPrint('Favorite button tapped');
                // Implement favorite logic
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Red for favorite/heart
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.025),
                ),
              ),
              child: Icon(Icons.favorite_border, color: Colors.white, size: screenWidth * 0.05),
            ),
          ),
        ],
      ),
    );
  }
}
