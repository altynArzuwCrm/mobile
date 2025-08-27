import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await NotificationService.instance.setupFlutterNotifications();
  await NotificationService.instance.showNotification(message);
}

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  final _messaging = FirebaseMessaging.instance;
  bool isFlutterLocalNotificationInitialized = false;

  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    await _requestPermission();
    await _setupMessageHandlers();
  }

  Future<void> _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      provisional: false,
      announcement: false,
      carPlay: false,
      criticalAlert: false,
    );

    debugPrint("Permission status: ${settings.authorizationStatus}");
  }

  Future<void> setupFlutterNotifications() async {
    if (isFlutterLocalNotificationInitialized) return;

    const channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications',
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    const initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettingsDarwin = DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        final payload = details.payload;
        if (payload != null) {
          final data = jsonDecode(payload);
          debugPrint("Notification tapped with data: $data");

          // Example navigation logic
          if (data['type'] == 'chat') {
            debugPrint("Navigate to chat screen");
            // TODO: Add your app-specific navigation here
          }
        }
      },
    );

    isFlutterLocalNotificationInitialized = true;
  }

  Future<void> showNotification(RemoteMessage message) async {
    final notification = message.notification;

    if (notification != null || message.data.isNotEmpty) {
      await flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification?.title ?? 'New Message',
        notification?.body ?? '',
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'high_importance_channel',
            'High Importance Channel',
            channelDescription: 'This channel is used for important notifications',
            importance: Importance.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        payload: jsonEncode(message.data), // ✅ Clean payload for tap handling
      );
    }
  }

  Future<void> _setupMessageHandlers() async {
    // Foreground notification
    FirebaseMessaging.onMessage.listen((message) async {
      final prefs = await SharedPreferences.getInstance();
      final isNotificationsEnabled =
          prefs.getBool('notifications_enabled') ?? true;

      if (isNotificationsEnabled) {
        await showNotification(message);
      }
    });

    // Tapped from background
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

    // Tapped from terminated state
    final initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      await _handleNotificationTap(initialMessage);
    }

    // Token refresh
    _messaging.onTokenRefresh.listen((String? newToken) async {
      if (newToken == null) return;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('fcm_token', newToken);
    });
  }

  Future<void> _handleNotificationTap(RemoteMessage message) async {
    final data = message.data;

    if (data['type'] == 'chat') {
      debugPrint("Open chat screen based on notification");
      // TODO: Add your navigation logic here (e.g. using a navigator key)
    }
  }

  Future<void> unregisterNotifications() async {
    final androidPlugin =
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (androidPlugin != null) {
      await androidPlugin.deleteNotificationChannel('high_importance_channel');
    }
  }
}
