// lib/screens/review_product_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ReviewProductPage extends StatelessWidget {
  const ReviewProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final textScaleFactor = mediaQuery.textScaler.scale(1.0);

    // Sample data for reviews
    final List<Map<String, String>> reviews = [
      {
        'name': 'Yelena Belova',
        'rating': '4.0', // Assuming 4 stars for visual representation
        'time': '2 Minggu yang lalu',
        'comment': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      },
      {
        'name': 'Stephen Strange',
        'rating': '3.5',
        'time': '1 Bulan yang lalu',
        'comment': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      },
      {
        'name': 'Peter Parker',
        'rating': '4.5',
        'time': '2 Bulan yang lalu',
        'comment': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      },
      {
        'name': 'T\'chala',
        'rating': '5.0',
        'time': '1 Bulan yang lalu',
        'comment': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      },
      {
        'name': 'Tony Stark',
        'rating': '3.0',
        'time': '2 Bulan yang lalu',
        'comment': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      },
      {
        'name': 'Peter Quil',
        'rating': '4.0',
        'time': '1 Bulan yang lalu',
        'comment': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      },
      {
        'name': 'Wanda Maximof',
        'rating': '5.0',
        'time': '2 Bulan yang lalu',
        'comment': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
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
          'Review Product',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05,
          ),
        ),
        centerTitle: true,
        actions: [
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: screenWidth * 0.04),
              Text(
                '4.6',
                style: TextStyle(fontSize: screenWidth * 0.035 / textScaleFactor, color: Colors.grey[700]),
              ),
              SizedBox(width: screenWidth * 0.04), // Padding for the icon
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Overall Rating Summary Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '4.6/5',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.08 / textScaleFactor,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '86 Reviews',
                        style: TextStyle(
                          fontSize: screenWidth * 0.035 / textScaleFactor,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: screenWidth * 0.05),
                  Expanded(
                    child: Column(
                      children: [
                        _buildRatingBar(5, 70, screenWidth, screenHeight, textScaleFactor), // Pass screenHeight
                        _buildRatingBar(4, 5, screenWidth, screenHeight, textScaleFactor), // Pass screenHeight
                        _buildRatingBar(3, 8, screenWidth, screenHeight, textScaleFactor), // Pass screenHeight
                        _buildRatingBar(2, 2, screenWidth, screenHeight, textScaleFactor), // Pass screenHeight
                        _buildRatingBar(1, 1, screenWidth, screenHeight, textScaleFactor), // Pass screenHeight
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02),

            // Individual Reviews Section
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
          ],
        ),
      ),
    );
  }

  // Helper method to build a single rating bar (e.g., 5 stars, 4 stars)
  Widget _buildRatingBar(int stars, int count, double screenWidth, double screenHeight, double textScaleFactor) { // Added screenHeight
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.005),
      child: Row(
        children: [
          Text(
            '$stars',
            style: TextStyle(fontSize: screenWidth * 0.035 / textScaleFactor, color: Colors.grey[700]),
          ),
          SizedBox(width: screenWidth * 0.01),
          Icon(Icons.star, color: Colors.amber, size: screenWidth * 0.035),
          SizedBox(width: screenWidth * 0.01),
          Expanded(
            child: LinearProgressIndicator(
              value: count / 70.0, // Max count is 70 based on image
              backgroundColor: Colors.grey[300],
              color: Colors.amber,
              minHeight: screenHeight * 0.008,
              borderRadius: BorderRadius.circular(screenWidth * 0.01),
            ),
          ),
          SizedBox(width: screenWidth * 0.02),
          Text(
            '$count',
            style: TextStyle(fontSize: screenWidth * 0.035 / textScaleFactor, color: Colors.grey[700]),
          ),
        ],
      ),
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
                      // Display stars based on the rating value
                      ...List.generate(5, (index) {
                        return Icon(
                          index < double.parse(rating).floor()
                              ? Icons.star
                              : (index < double.parse(rating) ? Icons.star_half : Icons.star_border),
                          color: Colors.amber,
                          size: screenWidth * 0.035,
                        );
                      }),
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
}