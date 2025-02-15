import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tadamon/core/controller/network_controller/network_controller.dart';
import 'package:tadamon/core/routing/app_router.dart';
import 'package:tadamon/features/products_scanner/data/models/product_model_hive.dart';
import 'package:tadamon/features/report_products/logic/services/report_service.dart';
import 'package:tadamon/firebase_options.dart';
import 'package:tadamon/tadamon.dart';

/// The main entry point of the application.
/// 
/// This function ensures the necessary initializations are completed before
/// running the app. It:
/// - Ensures that the Flutter binding is initialized.
/// - Initializes shared preferences for the ReportService.
/// - Initializes Firebase with the default platform options.
/// - Initializes Hive for local database storage and registers a Hive adapter
///   for the `HiveProductModel`.
/// - Initializes the NetworkController for network status monitoring.
/// - Finally, it runs the `TadamonApp` with the provided `AppRouter`.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ReportService.initializePreferences();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  await Hive.initFlutter();
  Hive.registerAdapter(HiveProductModelAdapter());
  NetworkController().initNetworkController();
  runApp(TadamonApp(AppRouter(),));
}
