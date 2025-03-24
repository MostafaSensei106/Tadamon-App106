import 'dart:io';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tadamon/core/routing/app_router.dart';
import 'package:tadamon/core/services/object_box_services/object_box_service.dart';
import 'package:tadamon/firebase_options.dart';
import 'package:tadamon/tadamon.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

await ObjectBoxService.init();
  if(Platform.isAndroid) {
  }

  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
  );
  runApp(TadamonApp(AppRouter()));
}
