import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'core/utils/fcm/notification_service.dart';
import 'locator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await NotificationService.instance.setupFlutterNotifications();
    await NotificationService.instance.initialize();

    await initLocator();
  } catch (e) {
    debugPrint(e.toString());
  }
  runApp(const AppStart());
}
