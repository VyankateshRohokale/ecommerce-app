// lib/screens/news_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final textScaleFactor = mediaQuery.textScaler.scale(1.0);

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
          'News',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search News',
                  hintStyle: TextStyle(fontSize: screenWidth * 0.035 / textScaleFactor),
                  prefixIcon: Icon(Icons.search, color: Colors.grey, size: screenWidth * 0.05),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.025),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                ),
                style: TextStyle(fontSize: screenWidth * 0.04 / textScaleFactor),
                onSubmitted: (value) {
                  debugPrint('News search submitted: $value');
                },
              ),
            ),
            // News List
            _buildNewsListItem(
              context,
              'Philosophy That Addresses Topics Such As Goodness',
              'Agar tetap kinclong, bodi motor ten...',
              '13 Jan 2021',
              'assets/images/news.png', // Changed to local asset
              screenWidth,
              screenHeight,
              textScaleFactor,
            ),
            _buildNewsListItem(
              context,
              'Many Inquiries Outside Of Academia Are Philosophical In The Broad Sense',
              'In one general sense, philosophy is ass...',
              '13 Jan 2021',
              'assets/images/news.png', // Changed to local asset
              screenWidth,
              screenHeight,
              textScaleFactor,
            ),
            _buildNewsListItem(
              context,
              'Tips Merawat Bodi Mobil agar Tidak Terlihat Kusam',
              'Agar tetap kinclong, bodi motor ten...',
              '13 Jan 2021',
              'assets/images/news.png', // Changed to local asset
              screenWidth,
              screenHeight,
              textScaleFactor,
            ),
            _buildNewsListItem(
              context,
              'Many Inquiries Outside Of Academia Are Philosophical In The Broad Sense',
              'In one general sense, philosophy is ass...',
              '13 Jan 2021',
              'assets/images/news.png', // Changed to local asset
              screenWidth,
              screenHeight,
              textScaleFactor,
            ),
            _buildNewsListItem(
              context,
              'Tips Merawat Bodi Mobil agar Tidak Terlihat Kusam',
              'Agar tetap kinclong, bodi motor ten...',
              '13 Jan 2021',
              'assets/images/news.png', // Changed to local asset
              screenWidth,
              screenHeight,
              textScaleFactor,
            ),
            SizedBox(height: screenHeight * 0.02), // Add some bottom padding
          ],
        ),
      ),
    );
  }

  // Helper method to build individual news list items
  Widget _buildNewsListItem(
      BuildContext context,
      String title,
      String description,
      String date,
      String imageUrl,
      double screenWidth,
      double screenHeight,
      double textScaleFactor) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.01),
      child: Container(
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
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.03),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screenWidth * 0.04 / textScaleFactor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    Text(
                      description,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: screenWidth * 0.035 / textScaleFactor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    Text(
                      date,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: screenWidth * 0.03 / textScaleFactor,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: screenWidth * 0.03),
              ClipRRect(
                borderRadius: BorderRadius.circular(screenWidth * 0.02),
                child: Image.asset( // Changed from Image.network to Image.asset
                  imageUrl, // This will now be 'assets/images/news.png'
                  width: screenWidth * 0.25, // Square image as in the reference
                  height: screenWidth * 0.25, // Square image as in the reference
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: screenWidth * 0.25,
                      height: screenWidth * 0.25,
                      color: Colors.grey[300],
                      child: Icon(Icons.broken_image, color: Colors.grey[600]),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
