import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tadamon/core/controller/network_controller/network_controller.dart';
import 'package:tadamon/core/routing/app_router.dart';
import 'package:tadamon/features/report_products/logic/services/report_service.dart';
import 'package:tadamon/firebase_options.dart';
import 'package:tadamon/tadamon.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ReportService.initializePreferences();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  NetworkController().initNetworkController();
  
  runApp(TadamonApp(AppRouter(),));
}
