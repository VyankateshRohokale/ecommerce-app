import 'package:ecommerce/screens/news_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'screens/home_page.dart'; // Assuming this is your HomePage
import 'screens/detail_product_page.dart'; // Your detail product page
import 'screens/signin_page.dart'; // Import your SignInPage
import 'providers/app_data_provider.dart';
import 'screens/detailed_news_page.dart'; // Corrected import path for DetailedNewsPage
import 'screens/search.dart'; // Corrected import path for SearchPage (assuming file is search_page.dart)

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
          path: 'news', // Route for the main News listing page
          builder: (BuildContext context, GoRouterState state) {
            return const NewsPage();
          },
        ),
        GoRoute(
          path: 'news_detail/:newsId', // Route for individual detailed news
          builder: (BuildContext context, GoRouterState state) {
            final String? newsId = state.pathParameters['newsId'];
            // This line correctly uses 'DetailedNewsPage'
            return DetailNewsPage(newsId: newsId);
          },
        ),
        // Add more routes as your app grows
      ],
    ),
    // Define the route for your HomePage explicitly (kept as per your provided code)
    GoRoute(
      path: '/home', // Explicit route for HomePage
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    // Define the route for your SignInPage
    GoRoute(
      path: '/signin', // This is the route path for your sign-in page
      builder: (BuildContext context, GoRouterState state) {
        return const SignInPage();
      },
    ),
    // Route for the SearchPage
    GoRoute(
      path: '/search',
      builder: (BuildContext context, GoRouterState state) {
        return const SearchPage(); // Uses the SearchPage class
      },
    ),
    // Example route for /detail, as used in your HomePage's cart button
    GoRoute(
      path: '/detail',
      builder: (BuildContext context, GoRouterState state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Detail Screen')),
          body: const Center(child: Text('This is a generic detail screen.')),
        );
      },
    ),
    // Example route for categories, as used in your HomePage's section headers
    GoRoute(
      path: '/category/:name',
      builder: (BuildContext context, GoRouterState state) {
        final categoryName = state.pathParameters['name'];
        return Scaffold(
          appBar: AppBar(title: Text('Category: ${categoryName ?? 'Unknown'}')),
          body: Center(child: Text('Content for ${categoryName ?? 'Unknown'} category')),
        );
      },
    ),
  ],
  // Optional: Add an error page for unknown routes
  // errorBuilder: (context, state) => ErrorScreen(error: state.error),
);


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Keep this as it's good practice

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppDataProvider()),
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
      ),
    );
  }
}
