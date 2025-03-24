<<<<<<< HEAD
import 'dart:io';

=======
>>>>>>> dfa27d125a1ba549826e6f8aacb581e7f45bfac0
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:tadamon/core/controller/network_controller/network_controller.dart';
import 'package:tadamon/core/error/erro_screen.dart';
import 'package:tadamon/core/routing/app_router.dart';
import 'package:tadamon/core/services/object_box_services/object_box_service.dart';
import 'package:tadamon/features/report_products/logic/services/report_service.dart';
import 'package:tadamon/firebase_options.dart';
import 'package:tadamon/tadamon.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
<<<<<<< HEAD
  FirebaseAppCheck firebaseAppCheck = FirebaseAppCheck.instance;  await ObjectBoxService.init();
  if(Platform.isAndroid) {
    await firebaseAppCheck.activate(androidProvider: AndroidProvider.debug);
  }
=======

  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
  );
  
  await ObjectBoxService.init();
>>>>>>> dfa27d125a1ba549826e6f8aacb581e7f45bfac0
  NetworkController().initNetworkController();
  errorScreen();
  await ReportService.initializePreferences();

  runApp(TadamonApp(
    AppRouter(),
  ),
  );
}
