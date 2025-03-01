import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CounterManager {

  static const String scannedProductsKey = 'scannedProductsCounter';
  static const String supportedProductsKey = 'supportedProductsCounter';

  // Stream for scanned products counter
  static final StreamController<int> _scannedProductsController =
      StreamController<int>.broadcast(onListen: initializeScannedProducts);
  static Stream<int> get scannedProductsStream =>
      _scannedProductsController.stream;

  // Stream for supported products counter
  static final StreamController<int> _supportedProductsController =
      StreamController<int>.broadcast(onListen: initializeSupportedProducts);
  static Stream<int> get supportedProductsStream =>
      _supportedProductsController.stream;

  // Initialize scanned products counter
  static Future<void> initializeScannedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    int counter = prefs.getInt(scannedProductsKey) ?? 0;
    _scannedProductsController.add(counter);
  }

  // Initialize supported products counter
  static Future<void> initializeSupportedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    int counter = prefs.getInt(supportedProductsKey) ?? 0;
    _supportedProductsController.add(counter);
  }

  // Get scanned products count from Firestore
  static Future<int> getScannedProductsCount() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('TadakProducts') 
        .get();
    return querySnapshot.docs.length;
  }

  // Increment scanned products counter
  static Future<void> incrementScannedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    int currentCounter = prefs.getInt(scannedProductsKey) ?? 0;
    currentCounter++;
    await prefs.setInt(scannedProductsKey, currentCounter);
    _scannedProductsController.add(currentCounter);
  }

  // Reset scanned products counter
  static Future<void> resetScannedProducts() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(scannedProductsKey, 0);
    _scannedProductsController.add(0);
  }

}