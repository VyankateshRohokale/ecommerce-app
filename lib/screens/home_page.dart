import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart'; 

import '../services/push_notification.dart'; 

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the PushNotificationService using Provider
    final notificationService = Provider.of<PushNotificationService>(context);

    // Use MediaQuery for responsiveness and to prevent overflow
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final textScaleFactor = MediaQuery.of(context).textScaleFactor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('E-Commerce Home'),
        // Example of responsive AppBar title
        titleTextStyle: TextStyle(fontSize: screenWidth * 0.05, color: Colors.white),
      ),
      body: SingleChildScrollView( // Prevents overflow for content that might exceed screen height
        padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch children horizontally
          children: [
            // Display FCM Token (for testing/debugging)
            Text(
              'Your FCM Token:',
              style: TextStyle(fontSize: screenWidth * 0.045 / textScaleFactor, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * 0.01), // Responsive spacing
            SelectableText( // Use SelectableText to easily copy the token
              notificationService.fcmToken ?? 'Token not available yet...',
              style: TextStyle(fontSize: screenWidth * 0.035 / textScaleFactor, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * 0.03),

            // Example of a responsive button
            ElevatedButton(
              onPressed: () {
                // Example of go_router navigation
                context.go('/product_detail/my_new_product_id');
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.02,
                  horizontal: screenWidth * 0.05,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenWidth * 0.02),
                ),
              ),
              child: Text(
                'View Sample Product',
                style: TextStyle(fontSize: screenWidth * 0.045 / textScaleFactor),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),

            // Another responsive element demonstrating MediaQuery for layout
            Container(
              width: screenWidth * 0.8, // Fixed width based on screen width
              height: screenHeight * 0.2, // Fixed height based on screen height
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
              decoration: BoxDecoration(
                color: Colors.lightBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.lightBlue, width: 2),
              ),
              child: Center(
                child: Text(
                  'This container scales responsively using MediaQuery.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: screenWidth * 0.04 / textScaleFactor),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),

            // Example of a Wrap widget to prevent overflow with many items
            Wrap(
              spacing: screenWidth * 0.02, // Horizontal spacing
              runSpacing: screenHeight * 0.01, // Vertical spacing
              alignment: WrapAlignment.center,
              children: List.generate(5, (index) =>
                Chip(
                  label: Text('Category ${index + 1}', style: TextStyle(fontSize: screenWidth * 0.035 / textScaleFactor)),
                  avatar: CircleAvatar(child: Text('${index + 1}')),
                  padding: EdgeInsets.all(screenWidth * 0.02),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}