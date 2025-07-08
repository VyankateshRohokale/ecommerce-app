import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart'; // Import provider package

import 'package:ecommerce/providers/favorite_provider.dart'; // Import your FavoriteProvider
import 'package:ecommerce/screens/home_page.dart';
import 'package:ecommerce/screens/detail_product_page.dart';
import 'package:ecommerce/screens/seller_info.dart'; // Corrected Import: InfoSellerPage to seller_info.dart
import 'package:ecommerce/screens/review_product.dart'; // Corrected Import: ReviewProductPage to review_product.dart
import 'package:ecommerce/screens/search.dart'; // Import SearchPage
import 'package:ecommerce/screens/news_page.dart'; // Import NewsPage
import 'package:ecommerce/screens/signin_page.dart'; // Import SignInPage
import 'package:ecommerce/providers/app_data_provider.dart'; // Import AppDataProvider
import 'package:ecommerce/screens/detailed_news_page.dart'; // Import DetailedNewsPage (assuming it's named DetailNewsPage class)


// Define a global key for GoRouter for navigation from non-widget contexts
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

// Define your GoRouter instance
final GoRouter _router = GoRouter(
  navigatorKey: _rootNavigatorKey, // Assign the global key here
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage(); // Your initial route, typically HomePage
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'product_detail/:productId',
          builder: (BuildContext context, GoRouterState state) {
            final String? productId = state.pathParameters['productId'];
            return DetailProductPage(productId: productId, extra: state.extra as Map<String, dynamic>?);
          },
        ),
        GoRoute(
          path: 'seller_info', // Route for InfoSellerPage (now correctly linked to seller_info.dart)
          builder: (BuildContext context, GoRouterState state) {
            return const InfoSellerPage(); // Assuming the class name is InfoSellerPage
          },
        ),
        GoRoute(
          path: 'review_product', // Route for ReviewProductPage (now correctly linked to review_product.dart)
          builder: (BuildContext context, GoRouterState state) {
            return const ReviewProductPage(); // Assuming the class name is ReviewProductPage
          },
        ),
        GoRoute(
          path: 'news', // Route for the main News listing page
          builder: (BuildContext context, GoRouterState state) {
            return const NewsPage();
          },
        ),
        GoRoute(
          path: 'news_detail/:newsId', // Route for individual detailed news
          builder: (BuildContext context, GoRouterState state) {
            final String? newsId = state.pathParameters['newsId'];
            return DetailNewsPage(newsId: newsId);
          },
        ),
        GoRoute(
          path: 'search', // Route for SearchPage
          builder: (BuildContext context, GoRouterState state) {
            return const SearchPage();
          },
        ),
        // Example route for /detail, as used in your HomePage's cart button
        GoRoute(
          path: 'detail',
          builder: (BuildContext context, GoRouterState state) {
            return Scaffold(
              appBar: AppBar(title: const Text('Detail Screen')),
              body: const Center(child: Text('This is a generic detail screen.')),
            );
          },
        ),
        // Example route for categories, as used in your HomePage's section headers
        GoRoute(
          path: 'category/:name',
          builder: (BuildContext context, GoRouterState state) {
            final categoryName = state.pathParameters['name'];
            return Scaffold(
              appBar: AppBar(title: Text('Category: ${categoryName ?? 'Unknown'}')),
              body: Center(child: Text('Content for ${categoryName ?? 'Unknown'} category')),
            );
          },
        ),
      ],
    ),
    // Define the route for your SignInPage outside the '/' nested routes
    GoRoute(
      path: '/signin', // This is the route path for your sign-in page
      builder: (BuildContext context, GoRouterState state) {
        return const SignInPage();
      },
    ),
  ],
  // Optional: Add an error page for unknown routes
  // errorBuilder: (context, state) => ErrorScreen(error: state.error),
);


void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Keep this as it's good practice

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppDataProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()), // Added FavoriteProvider here
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQueryData.copyWith(textScaler: TextScaler.noScaling),
      child: MaterialApp.router(
        title: 'Mega Mall',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Inter',
        ),
        routerConfig: _router,
        debugShowCheckedModeBanner: false, // Added this back for consistency
      ),
    );
  }
}
