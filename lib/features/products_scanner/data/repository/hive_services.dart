import 'package:hive/hive.dart';
import 'package:tadamon/features/products_scanner/data/models/product_model.dart';
import 'package:tadamon/features/products_scanner/data/models/product_model_hive.dart';
import 'package:tadamon/features/products_scanner/data/repository/fire_store_services.dart';

class HiveServices {
  static const String boxName = 'LocalTadamonProducts';

/// Synchronizes all products from the Firestore database to the local Hive database.
///
/// Opens a Hive box with the name [boxName] and retrieves all products from
/// the Firestore database using [FireStoreServices.getAllProducts].
/// Each product is then converted to a [ProductModel] and stored in the Hive
/// box using its serial number as the key.

  Future<void> syncAllProductsToHive() async {
    var box  = await Hive.openBox<HiveProductModel>(boxName);
    for (var product in await FireStoreServices().getAllProducts()) {
      var hiveProduct = HiveProductModel.fromProduct(product);
      box.put(hiveProduct.serialNumber, hiveProduct);
    }
  }

  /// Checks if the local Hive database contains any products.
  ///
  /// Opens a Hive box with the name [boxName] and checks if it contains any products.
  /// If the box is not empty, it means that the local database contains some products
  /// and the function returns true. Otherwise, it returns false.
  Future<bool> hiveDbHasData() async {
    var box = await Hive.openBox<HiveProductModel>(boxName);
    return box.values.isNotEmpty;
  }



  /// Retrieves a product from the local Hive database by its serial number.
  ///
  /// Opens a Hive box with the name [boxName] and retrieves a product with the
  /// given [serialNumber] using its serial number as the key.
  ///
  /// If the product is found, it is returned as a [H].
  ///
  /// If the product is not found, null is returned.
  Future<dynamic> getProductBySerialNumber(String serialNumber) async {
    var box = await Hive.openBox<HiveProductModel>(boxName);
    var hiveProduct = box.get(serialNumber);
    return hiveProduct?.toProduct().toMap();
  }

  /// Deletes all products from the local Hive database.
  ///
  /// Opens a Hive box with the name [boxName] and clears all products stored
  /// in the box using its [clear] method.
  Future<void> deleteAllLocalProducts() async {
    var box = await Hive.openBox<HiveProductModel>(boxName);
    await box.clear();
  }

}
