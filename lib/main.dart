import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tadamon/core/controller/network_controller/network_controller.dart';
import 'package:tadamon/core/routing/app_router.dart';
import 'package:tadamon/features/products_scanner/data/models/product_model_hive.dart';
import 'package:tadamon/features/report_products/logic/services/report_service.dart';
import 'package:tadamon/firebase_options.dart';
import 'package:tadamon/tadamon.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ReportService.initializePreferences();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  await Hive.initFlutter();
  Hive.registerAdapter(HiveProductModelAdapter());
  NetworkController().initNetworkController();
  runApp(TadamonApp(AppRouter(),));
}
