// lib/screens/mega_mall_home_page.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/app_data_provider.dart'; // Import your provider

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access MediaQuery data for responsive sizing
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final screenHeight = mediaQuery.size.height;
    final textScaleFactor = mediaQuery.textScaler.scale(1.0); // Get default text scale

    // Access your AppDataProvider using Provider
    final appDataProvider = Provider.of<AppDataProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            // Example of using provider to change a state
            appDataProvider.toggleSidebar();
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Sidebar status: ${appDataProvider.isSidebarOpen ? "Open" : "Closed"}')));
          },
        ),
        title: Text(
          'Mega Mall',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: screenWidth * 0.05, // Responsive font size
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {
              // Handle search tap
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {
              // Handle cart tap
              context.go('/detail'); // Navigate to detail screen (simulated cart)
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        // SingleChildScrollView prevents overflow if content exceeds screen height
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar Section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search here...',
                  hintStyle: TextStyle(fontSize: screenWidth * 0.035 / textScaleFactor),
                  prefixIcon: Icon(Icons.search, color: Colors.grey, size: screenWidth * 0.05),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.025),
                    borderSide: BorderSide.none, // No border line
                  ),
                  filled: true,
                  fillColor: Colors.grey[200], // Light grey background
                  contentPadding: EdgeInsets.symmetric(vertical: screenHeight * 0.015), // Responsive padding
                ),
                style: TextStyle(fontSize: screenWidth * 0.04 / textScaleFactor),
                onSubmitted: (value) {
                  // Handle search submission
                  debugPrint('Search submitted: $value');
                  // You might navigate to a search results page here
                  // context.go('/search_results?query=$value');
                },
              ),
            ),

            // Top Banner Section
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
              child: Container(
                height: screenHeight * 0.2, // Responsive height
                decoration: BoxDecoration(
                  color: Colors.redAccent, // This color will only be visible if the image doesn't load
                  borderRadius: BorderRadius.circular(screenWidth * 0.04), // Responsive border radius
                  // Set banner.png as the background image
                  image: const DecorationImage(
                    image: AssetImage('assets/images/banner.png'), // Your new banner image
                    fit: BoxFit.cover, // This makes the image cover the entire container
                    alignment: Alignment.center, // Center the image within the box
                  ),
                ),
                child: Stack(
                  children: [
                    // The image is now the background, so no need for a Positioned Image.asset here
                    // Removed the CircleAvatar as requested
                  ],
                ),
              ),
            ),

            // Categories Section (Using Wrap for better responsiveness if items overflow horizontally)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.01),
              child: Wrap(
                alignment: WrapAlignment.spaceAround,
                spacing: screenWidth * 0.02, // Horizontal spacing between items
                runSpacing: screenHeight * 0.01, // Vertical spacing between rows
                children: [
                  _buildCategoryItem(Icons.flash_on, 'Flash Sale', screenWidth, screenHeight, textScaleFactor),
                  _buildCategoryItem(Icons.card_giftcard, 'Voucher', screenWidth, screenHeight, textScaleFactor),
                  _buildCategoryItem(Icons.local_shipping, 'Delivery', screenWidth, screenHeight, textScaleFactor),
                  _buildCategoryItem(Icons.devices, 'Gadget', screenWidth, screenHeight, textScaleFactor),
                  _buildCategoryItem(Icons.more_horiz, 'More', screenWidth, screenHeight, textScaleFactor),
                ],
              ),
            ),

            // Featured Products Section
            _buildSectionHeader('Featured Product', 'View All', screenWidth, textScaleFactor, context, screenHeight),
            SizedBox(
              height: screenHeight * 0.3, // Responsive height for horizontal list
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                children: [
                  _buildProductCard(
                    context,
                    'TMX 210 Wireless',
                    'assets/images/headphone.jpg', // Changed to local asset
                    'Rp 1.000.000',
                    'Rp 750.000',
                    '25%',
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  ),
                  _buildProductCard(
                    context,
                    'TMX 210 Wireless',
                    'assets/images/headphone.jpg', // Changed to local asset
                    'Rp 1.000.000',
                    'Rp 750.000',
                    '25%',
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  ),
                  _buildProductCard(
                    context,
                    'TMX 210 Wireless',
                    'assets/images/headphone.jpg', // Changed to local asset
                    'Rp 1.000.000',
                    'Rp 750.000',
                    '25%',
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  ),
                ],
              ),
            ),

            // Mid Banner Section
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Container(
                height: screenHeight * 0.15,
                decoration: BoxDecoration(
                  color: Colors.green, // This color will only be visible if the image doesn't load
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  // Set greenbanner.png as the background image
                  image: const DecorationImage(
                    image: AssetImage('assets/images/greenbanner.png'), // Your new green banner image
                    fit: BoxFit.cover, // This makes the image cover the entire container
                    alignment: Alignment.center, // Center the image within the box
                  ),
                ),
                child: Center( // Keep Center for the text overlay on the banner
                  child: Text(
                    'Get 20% Off All\nMulti-Function Items!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.045 / textScaleFactor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),

            // Best Sellers Section
            _buildSectionHeader('Best Sellers', 'View All', screenWidth, textScaleFactor, context, screenHeight),
            SizedBox(
              height: screenHeight * 0.3,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                children: [
                  _buildProductCard(
                    context,
                    'TMX 210 Wireless',
                    'assets/images/headphone.jpg', // Changed to local asset
                    'Rp 1.000.000',
                    'Rp 750.000',
                    '25%',
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  ),
                  _buildProductCard(
                    context,
                    'TMX 210 Wireless',
                    'assets/images/headphone.jpg', // Changed to local asset (assuming drill is also now headphones)
                    'Rp 1.000.000',
                    'Rp 750.000',
                    '25%',
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  ),
                ],
              ),
            ),

            // Modular Headphones Banner
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Container(
                height: screenHeight * 0.2,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://placehold.co/600x150/4682B4/FFFFFF?text=Modular+Headphones'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: screenHeight * 0.03,
                      left: screenWidth * 0.05,
                      child: Text(
                        'Modular\nHeadphone',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.045 / textScaleFactor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                      bottom: screenHeight * 0.015,
                      right: screenWidth * 0.025,
                      child: Icon(Icons.headphones,
                          size: screenWidth * 0.15, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

            // New Arrivals Section (Still using product cards as per your code structure)
            _buildSectionHeader('New Arrivals', 'View All', screenWidth, textScaleFactor, context, screenHeight),
            SizedBox(
              height: screenHeight * 0.3,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                children: [
                  _buildProductCard(
                    context,
                    'TMX 210 Wireless',
                    'assets/images/headphone.jpg', // Changed to local asset
                    'Rp 1.000.000',
                    'Rp 750.000',
                    '25%',
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  ),
                  _buildProductCard(
                    context,
                    'TMX 210 Wireless',
                    'assets/images/headphone.jpg', // Changed to local asset
                    'Rp 1.000.000',
                    'Rp 750.000',
                    '25%',
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  ),
                ],
              ),
            ),

            // Top Rated Products Section
            _buildSectionHeader('Top Rated Product', 'View All', screenWidth, textScaleFactor, context, screenHeight),
            SizedBox(
              height: screenHeight * 0.3,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                children: [
                  _buildProductCard(
                    context,
                    'TMX 210 Wireless',
                    'assets/images/headphone.jpg', // Changed to local asset
                    'Rp 1.000.000',
                    'Rp 750.000',
                    '25%',
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  ),
                  _buildProductCard(
                    context,
                    'TMX 210 Wireless',
                    'assets/images/headphone.jpg', // Changed to local asset
                    'Rp 1.000.000',
                    'Rp 750.000',
                    '25%',
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  ),
                ],
              ),
            ),

            // Special Offers Section
            _buildSectionHeader('Special Offers', 'View All', screenWidth, textScaleFactor, context, screenHeight),
            SizedBox(
              height: screenHeight * 0.3,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                children: [
                  _buildProductCard(
                    context,
                    'TMX 210 Wireless',
                    'assets/images/headphone.jpg', // Changed to local asset (assuming drill is now headphones)
                    'Rp 1.000.000',
                    'Rp 750.000',
                    '25%',
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  ),
                  _buildProductCard(
                    context,
                    'TMX 210 Wireless',
                    'assets/images/headphone.jpg', // Changed to local asset
                    'Rp 1.000.000',
                    'Rp 750.000',
                    '25%',
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  ),
                ],
              ),
            ),

            // Latest News Section
            _buildSectionHeader('Latest News', 'View All', screenWidth, textScaleFactor, context, screenHeight),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Column(
                children: [
                  _buildNewsCard(
                    'How to apply the right makeup for your skin tone',
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    'https://placehold.co/100x80/CCCCCC/000000?text=News1', // News images remain NetworkImage
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  ),
                  _buildNewsCard(
                    'Best furniture for your new home',
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    'https://placehold.co/100x80/CCCCCC/000000?text=News2', // News images remain NetworkImage
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  ),
                  _buildNewsCard(
                    'Top 5 places to visit in Bali for your next vacation',
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                    'https://placehold.co/100x80/CCCCCC/000000?text=News3', // News images remain NetworkImage
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  ),
                ],
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle view all news
                  context.go('/detail'); // Example navigation
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1, vertical: screenHeight * 0.02),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth * 0.025),
                  ),
                ),
                child: Text(
                  'See All News',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth * 0.04 / textScaleFactor),
                ),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed, // Ensures all labels are shown
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: 'My Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  // Helper method to build category items
  Widget _buildCategoryItem(IconData icon, String label, double screenWidth, double screenHeight, double textScaleFactor) {
    return Column(
      children: [
        CircleAvatar(
          radius: screenWidth * 0.06, // Responsive radius
          backgroundColor: Colors.grey[200],
          child: Icon(icon, color: Colors.black, size: screenWidth * 0.06), // Responsive icon size
        ),
        SizedBox(height: screenHeight * 0.008),
        Text(
          label,
          style: TextStyle(fontSize: screenWidth * 0.03 / textScaleFactor, color: Colors.black), // Responsive font size
        ),
      ],
    );
  }

  // Helper method to build section headers
  Widget _buildSectionHeader(String title, String actionText, double screenWidth, double textScaleFactor, BuildContext context, double screenHeight) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.015),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: screenWidth * 0.045 / textScaleFactor, fontWeight: FontWeight.bold),
          ),
          TextButton(
            onPressed: () {
              // Example of navigation using go_router
              context.go('/category/${title.toLowerCase().replaceAll(' ', '_')}'); // Example: navigate to a category page
            },
            child: Text(
              actionText,
              style: TextStyle(color: Colors.blue, fontSize: screenWidth * 0.035 / textScaleFactor),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build product cards
  Widget _buildProductCard(
      BuildContext context, // Added BuildContext for navigation
      String title,
      String imageUrl, // This imageUrl will now be 'assets/images/headphone.jpg'
      String oldPrice,
      String newPrice,
      String discount,
      double screenWidth,
      double screenHeight,
      double textScaleFactor) {
    return GestureDetector(
      onTap: () {
        // Example of go_router navigation to a product detail page
        context.go('/product_detail/product_${title.hashCode}', extra: {'productName': title, 'imageUrl': imageUrl, 'newPrice': newPrice});
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
                    oldPrice,
                    style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                      fontSize: screenWidth * 0.03 / textScaleFactor,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        newPrice,
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold, fontSize: screenWidth * 0.035 / textScaleFactor),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.015, vertical: screenHeight * 0.003),
                        decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(screenWidth * 0.01),
                            ),
                            child: Text(
                            '$discount Off',
                            style: TextStyle(color: Colors.red, fontSize: screenWidth * 0.025 / textScaleFactor),
                            ),
                        ),
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

    // Helper method to build news cards
    Widget _buildNewsCard(
        String title, String description, String imageUrl, double screenWidth, double screenHeight, double textScaleFactor) {
        return Padding(
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.01),
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(screenWidth * 0.025),
                child: Image.network( // News cards still use NetworkImage
                imageUrl,
                width: screenWidth * 0.25, // Responsive width
                height: screenWidth * 0.2, // Responsive height
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                    return Container(
                    width: screenWidth * 0.25,
                    height: screenWidth * 0.2,
                    color: Colors.grey[300],
                    child: Icon(Icons.broken_image, color: Colors.grey[600]),
                    );
                },
                ),
            ),
            SizedBox(width: screenWidth * 0.025),
            Expanded(
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Text(
                    title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.038 / textScaleFactor),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: screenHeight * 0.005),
                    Text(
                    description,
                    style: TextStyle(color: Colors.grey, fontSize: screenWidth * 0.03 / textScaleFactor),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    ),
                ],
                ),
            ),
            ],
        ),
        );
    }
    }