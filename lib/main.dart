import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';

import '../services/push_notification.dart'; 
import '../screens/home_page.dart'; 

// --- TOP-LEVEL FUNCTION FOR BACKGROUND MESSAGES ---
// This needs to be a top-level function (not inside a class)
@pragma('vm:entry-point') // Required for background processing
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Ensure Firebase is initialized even for background messages
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");

  // Optionally, you can trigger a local notification here for background messages
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  // const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  // await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  // // Display local notification (simplified)
  // if (message.notification != null) {
  //   flutterLocalNotificationsPlugin.show(
  //     message.notification.hashCode,
  //     message.notification!.title,
  //     message.notification!.body,
  //     const NotificationDetails(android: AndroidNotificationDetails('background_channel', 'Background Notifications')),
  //   );
  // }
}
// ---------------------------------------------------

// Define your GoRouter instance globally or as a static member if preferred,
// so it can be accessed for navigation.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage(); // Your home page
      },
      routes: <RouteBase>[
        // Example: a product detail page accessible via deep link from notification
        GoRoute(
          path: 'product_detail/:productId',
          builder: (BuildContext context, GoRouterState state) {
            final String? productId = state.pathParameters['productId'];
            return ProductDetailPage(productId: productId); // A dummy product detail page
          },
        ),
        // Add other routes based on your Figma design here
      ],
    ),
  ],
  // You might add an errorBuilder for 404 pages
  // errorBuilder: (context, state) => ErrorScreen(error: state.error),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase first
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler); // Set up background handler

  // Initialize Flutter Local Notifications for foreground notifications
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher'); // Your app icon
  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true);
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // This callback is for when a local notification is tapped
        // You can use GoRouter here to navigate based on the payload
        print('Notification tapped with payload: ${response.payload}');
        if (response.payload != null && response.payload!.startsWith('/')) {
           _router.go(response.payload!); // Navigate using go_router
        }
      });


  runApp(
    MultiProvider(
      providers: [
        // Your existing Providers will go here
        // For push notifications, provide your NotificationService
        ChangeNotifierProvider(create: (_) => PushNotificationService(flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin)),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Access the PushNotificationService and initialize FCM listeners
    // This will trigger permission requests and token retrieval
    final notificationService = Provider.of<PushNotificationService>(context, listen: false);
    notificationService.initializeNotificationHandlers(); // Call the method to set up listeners
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'E-Commerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerConfig: _router,
      // Apply MediaQuery for global responsiveness and overflow prevention
      builder: (context, child) {
        // You can adjust this to your needs. This example prevents text scaling.
        final mediaQueryData = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQueryData.copyWith(textScaler: TextScaler.noScaling),
          child: child!,
        );
      },
    );
  }
}

// Dummy ProductDetailPage to show go_router navigation
class ProductDetailPage extends StatelessWidget {
  final String? productId;
  const ProductDetailPage({super.key, this.productId});

  @override
  Widget build(BuildContext context) {
    // Example of using MediaQuery for responsive UI
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text('Product Detail: ${productId ?? "N/A"}')),
      body: SingleChildScrollView( // Essential for preventing overflow on long content
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                height: screenHeight * 0.3, // Example of responsive height
                color: Colors.grey[300],
                child: Center(child: Text('Product Image Placeholder')),
              ),
              const SizedBox(height: 20),
              Text(
                'This is the detail page for product ID: $productId. Notification deep link successful!',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              // More content here that might cause overflow without SingleChildScrollView or Expanded/Flexible
            ],
          ),
        ),
      ),
    );
  }
}