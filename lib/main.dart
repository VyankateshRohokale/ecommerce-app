import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../screens/home_page.dart';
import '../screens/detail_product_page.dart'; // Corrected import
import '../providers/app_data_provider.dart';

// Define your GoRouter instance
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: <RouteBase>[
        // Example: Navigate to a product detail page
        GoRoute(
          path: 'product_detail/:productId', // Path remains the same for cleaner URLs
          builder: (BuildContext context, GoRouterState state) {
            final String? productId = state.pathParameters['productId'];
            // Use the corrected page name here
            return DetailProductPage(productId: productId);
          },
        ),
        // Add more routes as your app grows
      ],
    ),
  ],
  // Optional: Add an error page for unknown routes
  // errorBuilder: (context, state) => ErrorScreen(error: state.error),
);

void main() {
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
    return MaterialApp.router(
      title: 'Mega Mall',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter',
      ),
      routerConfig: _router,
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQueryData.copyWith(textScaler: TextScaler.noScaling),
          child: child!,
        );
      },
    );
  }
}