// lib/services/push_notification.dart
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:go_router/go_router.dart';

class PushNotificationService extends ChangeNotifier {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;

  String? _fcmToken;
  String? get fcmToken => _fcmToken;

  PushNotificationService({required FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin})
      : _flutterLocalNotificationsPlugin = flutterLocalNotificationsPlugin;

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
    notifyListeners();

    // *** IMPORTANT: Subscribe to the topic here ***
    await _firebaseMessaging.subscribeToTopic('all_users');
    print("Subscribed to topic: all_users");


    // Listen for token refresh
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      _fcmToken = newToken;
      print("FCM Token Refreshed: $_fcmToken");
      notifyListeners();
      // TODO: Send the new token to your backend server if you have one
      // And resubscribe to topics if necessary, though FCM usually handles this.
    });

    // Handle messages when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
        _showLocalNotification(message); // Show a local notification using flutter_local_notifications
      } else {
        // Handle data-only messages in foreground if needed
        print('Foreground message has no notification payload, only data.');
        // You might want to show a local notification from data here too
        if (message.data['title'] != null && message.data['body'] != null) {
            _showLocalNotificationFromData(message);
        }
      }
    });

    // Handle messages when the app is opened from a terminated state
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        print('App opened from terminated state by notification: ${message.data}');
        Future.delayed(Duration(milliseconds: 500), () => _handleNotificationTap(message));
      }
    });

    // Handle messages when the app is opened from a background state
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
          iOS: const DarwinNotificationDetails(), // Add iOS details
        ),
        // Pass data as payload for handling taps
        payload: message.data['route'] ?? '/', // Default to home if no route
      );
    }
  }

  // New helper for data-only foreground messages
  void _showLocalNotificationFromData(RemoteMessage message) {
    // Use data payload for title and body if notification object is absent
    String? title = message.data['title'];
    String? body = message.data['body'];

    if (title != null && body != null) {
      _flutterLocalNotificationsPlugin.show(
        message.hashCode, // Unique ID for the notification
        title,
        body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel', // Make sure this channel exists and is configured
            'High Importance Notifications',
            channelDescription: 'This channel is used for important notifications.',
            importance: Importance.max,
            priority: Priority.high,
            // icon: 'ic_notification', // You might need to specify a default icon if not using android.smallIcon
          ),
          iOS: const DarwinNotificationDetails(),
        ),
        payload: message.data['route'] ?? '/',
      );
    }
  }


  // Helper to handle navigation when a notification is tapped
  void _handleNotificationTap(RemoteMessage message) {
    final String? route = message.data['route'];
    if (route != null) {
      print('Attempting to navigate to: $route with data: ${message.data}');
      // Here's where you need to hook into GoRouter.
      // Option 1: Global Navigator Key (Recommended for services)
      // If you've defined: `final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();`
      // in main.dart and used it in GoRouter(navigatorKey: _rootNavigatorKey, ...), then:
      // _rootNavigatorKey.currentState?.context.go(route, extra: message.data);

      // Option 2: Passing the router instance (less common but possible)
      // If you pass the _router instance from main.dart to PushNotificationService
      // during its creation, you could call _router.go(...).

      // For now, let's just print. For actual navigation, you'll need one of the above.
    }
  }

  // You might also want a method to unsubscribe from a topic
  Future<void> unsubscribeFromTopic(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
    print("Unsubscribed from topic: $topic");
  }
}