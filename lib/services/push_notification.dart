import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart'; // IMP : this is for navigation 

// You'll need to define how to access your GoRouter instance.
// A common way is to pass the router instance or a Navigator key.
// For simplicity in this service, we will assume GoRouter.of(context)
// can be used if a BuildContext is provided, or we can use a global navigator key.
// For now, let's assume we can get the router from context when needed,
// or that the navigation will be handled by a function passed in.

class PushNotificationService extends ChangeNotifier {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  String? _fcmToken;
  String? get fcmToken => _fcmToken;

  // Constructor to receive the flutterLocalNotificationsPlugin instance
  PushNotificationService({required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin})
      : _flutterLocalNotificationsPlugin = flutterLocalNotificationsPlugin;

  // This method will be called from MyApp's initState
  Future<void> initializeNotificationHandlers() async {
    // Request permissions for iOS/macOS
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission for notifications');
    } else {
      print('User denied or has not yet granted permission for notifications');
    }

    // Get FCM token
    _fcmToken = await _firebaseMessaging.getToken();
    print("FCM Token: $_fcmToken");
    notifyListeners(); // Notify listeners when token is available

    // Listen for token refresh
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      _fcmToken = newToken;
      print("FCM Token Refreshed: $_fcmToken");
      notifyListeners();
      // TODO: Send the new token to your backend server if you have one
    });

    // Handle messages when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        _showLocalNotification(message); // Show a local notification using flutter_local_notifications
      }
    });

    // Handle messages when the app is opened from a terminated state
    // This is called when the app is launched from a notification tap
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print('App opened from terminated state by notification: ${message.data}');
        // Delaying navigation slightly to ensure router is ready
        Future.delayed(Duration(milliseconds: 500), () => _handleNotificationTap(message));
      }
    });

    // Handle messages when the app is opened from a background state
    // This is called when the app is running in the background and a notification is tapped
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('App opened from background by notification: ${message.data}');
      _handleNotificationTap(message);
    });
  }

  // Helper to show a local notification when app is in foreground
  void _showLocalNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel', // id
            'High Importance Notifications', // name
            channelDescription: 'This channel is used for important notifications.', // description
            icon: android.smallIcon, // make sure your app icon is set up correctly
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker',
          ),
        ),
        // Pass data as payload for handling taps
        payload: message.data['route'] ?? '/', // Default to home if no route
      );
    }
  }

  // Helper to handle navigation when a notification is tapped
  void _handleNotificationTap(RemoteMessage message) {
    // Assuming your notification payload contains a 'route' field
    // e.g., {'route': '/product_detail/123', 'productId': '123'}
    final String? route = message.data['route'];
    if (route != null) {
      // For go_router, if you can't get context directly,
      // you need a global key for the navigator or access the router directly.
      // Since _router is global in main.dart, we can use it.
      // Make sure the _router instance in main.dart is accessible.
      // Alternatively, if you're navigating from a widget, you'd do:
      // GoRouter.of(context).go(route, extra: message.data);
      // For a service, it's trickier without a global key.
      // One approach is to pass a callback from main.dart to this service for navigation.
      // For demonstration, let's just print.
      print('Attempting to navigate to: $route with data: ${message.data}');
      // A common pattern for services without context is to use a global key for GoRouter
      // or to have the service emit an event that a widget listens to for navigation.
      // For direct navigation in this setup:
      // You could pass the router instance to the service during creation.
      // For this example, let's assume `_router` from main.dart is accessible or
      // that we're relying on the `onDidReceiveNotificationResponse` in main.dart.
      // If direct navigation from service is a must, you'll need `navigatorKey` in go_router:
      // import 'package:go_router/go_router.dart';
      // final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
      // Then in MyApp:
      // routerConfig: GoRouter(navigatorKey: navigatorKey, ...);
      // And here: navigatorKey.currentState?.context.go(route, extra: message.data);
    }
  }
}