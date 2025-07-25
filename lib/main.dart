import 'package:flutter/material.dart';

import 'app.dart';
import 'locator.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initLocator();

  runApp(const AppStart());
}
