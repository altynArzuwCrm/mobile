import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetFcmToken {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  Future<String?> getFcmToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? storedToken = prefs.getString('fcm_token');

      if (storedToken == null) {
        String? token = await messaging.getToken();
        if (token != null) {
          await prefs.setString('fcm_token', token);
          log("Saved FCM Token: $token");
        }
        return token;
      } else {
        log("Using stored FCM Token: $storedToken");
        return storedToken;
      }
    } catch (e) {
      log("Error getting FCM Token: $e");
      return "";
    }
  }
}
