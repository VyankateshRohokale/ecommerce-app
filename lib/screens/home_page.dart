import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce/providers/app_data_provider.dart';
import 'package:ecommerce/screens/detail_product_page.dart';
import 'package:ecommerce/screens/news_page.dart';
import 'package:ecommerce/screens/search.dart';
import 'package:ecommerce/screens/category_product_page.dart'; // Ensure this is imported

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // State variable for the selected bottom navigation item

  // Sample data for categories (consolidated to match your Wrap usage and previous lists)
  final List<Map<String, dynamic>> categories = [
    {'name': 'Flash Sale', 'icon': Icons.flash_on},
    {'name': 'Voucher', 'icon': Icons.card_giftcard},
    {'name': 'Delivery', 'icon': Icons.local_shipping},
    {'name': 'Gadget', 'icon': Icons.devices},
    {'name': 'More', 'icon': Icons.more_horiz},
    {'name': 'Electronic', 'icon': Icons.lightbulb_outline},
    {'name': 'Fashion', 'icon': Icons.accessibility_new},
    {'name': 'Food', 'icon': Icons.fastfood},
    {'name': 'Sport', 'icon': Icons.sports_baseball},
    {'name': 'Health', 'icon': Icons.medical_services},
    {'name': 'Book', 'icon': Icons.book},
  ];

  // Sample data for "Featured Product"
  final List<Map<String, String>> featuredProducts = [
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

  // Sample data for "News"
  final List<Map<String, String>> newsItems = [
    {
      'title': 'Tips Memilih Headphone Gaming Terbaik',
      'imageUrl': 'assets/images/news_headphone.jpg',
      'date': '20 Mei 2024',
    },
    {
      'title': 'Smartphone Terbaru Rilis with Advanced Features', // Changed to English for consistency
      'imageUrl': 'assets/images/news_phone.jpg',
      'date': '18 Mei 2024',
    },
  ];

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
              // Handle search tap - Navigate to the SearchPage using push
              context.push('/search');
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
              child: GestureDetector(
                onTap: () {
                  // Navigate to the SearchPage when the search bar is tapped using push
                  context.push('/search');
                },
                child: AbsorbPointer(
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
                      // This will still work if the user types and presses enter,
                      // but the primary interaction is now the tap to navigate.
                      debugPrint('Search submitted from HomePage search bar: $value');
                    },
                  ),
                ),
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
                child: const Stack(
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
                alignment: WrapAlignment.start, // Aligned to start as per 007.png
                spacing: screenWidth * 0.04, // Horizontal spacing between items (adjusted for more space)
                runSpacing: screenHeight * 0.02, // Vertical spacing between rows (adjusted for more space)
                children: categories.map((category) {
                  return _buildCategoryItem(
                    context,
                    category['icon'] as IconData, // Pass IconData first
                    category['name'] as String, // Pass name second
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  );
                }).toList(),
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
                    'assets/images/headphone.jpg', // Changed to local asset (assuming drill is also now headphones)
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
                // Removed the Center widget containing the Text
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

            // Modular Headphones Banner - UPDATED TO USE bluebanner.png
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.04),
              child: Container(
                height: screenHeight * 0.2,
                decoration: BoxDecoration(
                  color: Colors.blueAccent, // This color will only be visible if the image doesn't load
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/bluebanner.png'), // Your new blue banner image
                    fit: BoxFit.cover, // This makes the image cover the entire container
                    alignment: Alignment.center, // Center the image within the box
                  ),
                ),
                child: const Stack( // Keep Stack if you might add overlay elements later, otherwise can be removed
                  children: [
                    // Removed the Positioned Text and Icon as the image now covers the area
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
                    'assets/images/headphone.jpg', // Changed to local asset (assuming drill is also now headphones)
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
                    context, // Pass context here
                    'How to apply the right makeup for your skin tone',
                    'assets/images/news.png', // Changed to local asset
                    '20 Mei 2024', // Date added for consistency
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  ),
                  _buildNewsCard(
                    context, // Pass context here
                    'Best furniture for your new home',
                    'assets/images/news.png', // Changed to local asset
                    '18 Mei 2024', // Date added for consistency
                    screenWidth,
                    screenHeight,
                    textScaleFactor,
                  ),
                  _buildNewsCard(
                    context, // Pass context here
                    'Top 5 places to visit in Bali for your next vacation',
                    'assets/images/news.png', // Changed to local asset
                    '15 Mei 2024', // Date added for consistency
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
                  // Handle view all news - Navigate to the main News listing page
                  context.go('/news');
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
        currentIndex: _selectedIndex, // Use the state variable
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed, // Ensures all labels are shown
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
          debugPrint('BottomNavigationBar tapped at index: $index'); // Debug print
          switch (index) {
            case 0: // Home
              context.go('/'); // Navigate to the root (HomePage)
              break;
            case 1: // Wishlist
            // context.go('/wishlist'); // You might need to define this route
              break;
            case 2: // My Order
            // context.go('/my_order'); // You might need to define this route
              break;
            case 3: // Profile
              debugPrint('Profile icon tapped. Showing login dialog.');
              _showLoginRequiredDialog(context, screenWidth, screenHeight, textScaleFactor); // Show the dialog
              break;
          }
        },
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
  Widget _buildCategoryItem(
      BuildContext context, // Added BuildContext parameter
      IconData icon,
      String label,
      double screenWidth,
      double screenHeight,
      double textScaleFactor) {
    return GestureDetector( // THIS IS THE WRAPPER FOR TAP DETECTION
      onTap: () {
        debugPrint('Category tapped: $label'); // Debug print to confirm tap
        // Navigate to the CategoryProductPage with the tapped category name
        context.push('/category_products/$label');
      },
      child: Column(
        children: [
          Container( // Wrap CircleAvatar in a Container for shadow
            decoration: BoxDecoration(
              color: Colors.white, // White background as seen in the image
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2), // Subtle shadow
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2), // Position of shadow
                ),
              ],
            ),
            child: CircleAvatar(
              radius: screenWidth * 0.06, // Responsive radius
              backgroundColor: Colors.transparent, // Make CircleAvatar transparent to show Container's color/shadow
              child: Icon(icon, color: Colors.black87, size: screenWidth * 0.06), // Softer black for icon
            ),
          ),
          SizedBox(height: screenHeight * 0.008), // Spacing between icon and text
          Text(
            label,
            style: TextStyle(fontSize: screenWidth * 0.03 / textScaleFactor, color: Colors.black), // Responsive font size
          ),
        ],
      ),
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
              debugPrint('$actionText tapped for $title');
              // Example: Navigate to a page showing all products for this section
              // You would define specific routes for these in main.dart
              if (title == 'Featured Product') {
                // context.push('/featured_products');
              } else if (title == 'Best Sellers') {
                // context.push('/best_sellers');
              } else if (title == 'New Arrivals') {
                // context.push('/new_arrivals');
              } else if (title == 'Top Rated Product') {
                // context.push('/top_rated_products');
              } else if (title == 'Special Offers') {
                // context.push('/special_offers');
              }
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
        context.push('/product_detail/product_${title.hashCode}', extra: {'productName': title, 'imageUrl': imageUrl, 'newPrice': newPrice, 'productId': 'product_${title.hashCode}'});
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
                  Row(
                    children: [
                      Text(
                        newPrice,
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold, fontSize: screenWidth * 0.035 / textScaleFactor),
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      Text(
                        oldPrice,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: screenWidth * 0.03 / textScaleFactor,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      Text(
                        discount,
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: screenWidth * 0.03 / textScaleFactor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenHeight * 0.005),
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.amber, size: screenWidth * 0.035),
                      Text(
                        '4.6', // Hardcoded rating for now
                        style: TextStyle(fontSize: screenWidth * 0.03 / textScaleFactor, color: Colors.grey[700]),
                      ),
                      SizedBox(width: screenWidth * 0.01),
                      Text(
                        '(86 Reviews)', // Hardcoded reviews for now
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

  // Helper method to build news cards
  Widget _buildNewsCard(
      BuildContext context, // Added BuildContext parameter
      String title,
      String imageUrl,
      String date, // Added date parameter
      double screenWidth,
      double screenHeight,
      double textScaleFactor) {
    return GestureDetector(
      onTap: () {
        context.push('/news_detail/news_${title.hashCode}');
      },
      child: Container(
        width: screenWidth * 0.6, // Responsive width for news card
        margin: EdgeInsets.only(right: screenWidth * 0.04),
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
                height: screenHeight * 0.12, // Responsive height for news image
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: screenHeight * 0.12,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: Icon(Icons.broken_image, color: Colors.grey[600]),
                  );
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(screenWidth * 0.02),
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
                    date, // Display the date
                    style: TextStyle(fontSize: screenWidth * 0.03 / textScaleFactor, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // New helper method to show the login required dialog
  void _showLoginRequiredDialog(BuildContext context, double screenWidth, double screenHeight, double textScaleFactor) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(screenWidth * 0.04), // Responsive border radius
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          child: Container(
            padding: EdgeInsets.all(screenWidth * 0.05), // Responsive padding
            width: screenWidth * 0.8, // Responsive width
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.close, color: Colors.grey, size: screenWidth * 0.06), // Responsive icon size
                    onPressed: () {
                      Navigator.of(dialogContext).pop(); // Close the dialog
                    },
                  ),
                ),
                Text(
                  'Login Account',
                  style: TextStyle(
                    fontSize: screenWidth * 0.055 / textScaleFactor,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  '👋', // Waving hand emoji
                  style: TextStyle(fontSize: screenWidth * 0.15), // Large emoji size
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  'Anda perlu masuk terlebih dahulu',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045 / textScaleFactor,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  'Silahkan login/ register terlebih dahulu\nuntuk melakukan transaksi',
                  style: TextStyle(
                    fontSize: screenWidth * 0.035 / textScaleFactor,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight * 0.04),
                SizedBox(
                  width: double.infinity,
                  height: screenHeight * 0.06, // Responsive button height
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop(); // Close the dialog first
                      context.go('/signin'); // Navigate to the sign-in page
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.02),
                      ),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.045 / textScaleFactor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
