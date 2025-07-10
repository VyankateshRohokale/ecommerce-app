import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:ecommerce/providers/favorite_provider.dart';
import 'package:ecommerce/screens/home_page.dart';
import 'package:ecommerce/screens/detail_product_page.dart';
import 'package:ecommerce/screens/seller_info.dart';
import 'package:ecommerce/screens/review_product.dart';
import 'package:ecommerce/screens/search.dart';
import 'package:ecommerce/screens/news_page.dart';
import 'package:ecommerce/screens/signin_page.dart';
import 'package:ecommerce/providers/app_data_provider.dart';
import 'package:ecommerce/screens/detailed_news_page.dart';
import 'package:ecommerce/screens/category_product_page.dart'; 

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
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
        GoRoute(
          path: 'seller_info',
          builder: (BuildContext context, GoRouterState state) {
            return const InfoSellerPage();
          },
        ),
        GoRoute(
          path: 'review_product',
          builder: (BuildContext context, GoRouterState state) {
            return const ReviewProductPage();
          },
        ),
        GoRoute(
          path: 'news',
          builder: (BuildContext context, GoRouterState state) {
            return const NewsPage();
          },
        ),
        GoRoute(
          path: 'news_detail/:newsId',
          builder: (BuildContext context, GoRouterState state) {
            final String? newsId = state.pathParameters['newsId'];
            return DetailNewsPage(newsId: newsId);
          },
        ),
        GoRoute(
          path: 'search',
          builder: (BuildContext context, GoRouterState state) {
            return const SearchPage();
          },
        ),
        // THIS IS THE CRUCIAL ROUTE FOR CATEGORY PRODUCTS
        GoRoute(
          path: 'category_products/:categoryName',
          builder: (BuildContext context, GoRouterState state) {
            final String? categoryName = state.pathParameters['categoryName'];
            return CategoryProductPage(categoryName: categoryName ?? 'Unknown Category');
          },
        ),
        GoRoute(
          path: 'detail',
          builder: (BuildContext context, GoRouterState state) {
            return Scaffold(
              appBar: AppBar(title: const Text('Detail Screen')),
              body: const Center(child: Text('This is a generic detail screen.')),
            );
          },
        ),
        // This generic category route might be redundant if 'category_products' is used for all category taps
        // You can remove this if you intend to use only 'category_products/:categoryName' for all category navigations
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
    GoRoute(
      path: '/signin',
      builder: (BuildContext context, GoRouterState state) {
        return const SignInPage();
      },
    ),
    // You might also need routes for wishlist, my_orders, and profile if they are not nested under '/'
    GoRoute(
      path: '/wishlist',
      builder: (BuildContext context, GoRouterState state) {
        return Scaffold(appBar: AppBar(title: const Text('Wishlist')), body: const Center(child: Text('Your Wishlist')));
      },
    ),
    GoRoute(
      path: '/my_orders',
      builder: (BuildContext context, GoRouterState state) {
        return Scaffold(appBar: AppBar(title: const Text('My Orders')), body: const Center(child: Text('Your Orders')));
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (BuildContext context, GoRouterState state) {
        return Scaffold(appBar: AppBar(title: const Text('Profile')), body: const Center(child: Text('Your Profile')));
      },
    ),
  ],
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppDataProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
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
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
