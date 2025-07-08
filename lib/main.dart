import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'screens/home_page.dart';
import 'screens/detail_product_page.dart';
import 'providers/app_data_provider.dart';

// Define a global key for GoRouter for navigation from non-widget contexts
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

// Define your GoRouter instance
final GoRouter _router = GoRouter(
  navigatorKey: _rootNavigatorKey, // Assign the global key here
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'product_detail/:productId',
          builder: (BuildContext context, GoRouterState state) {
            final String? productId = state.pathParameters['productId'];
            return DetailProductPage(productId: productId, extra: state.extra as Map<String, dynamic>?);
          },
        ),
        // Add more routes as your app grows
      ],
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