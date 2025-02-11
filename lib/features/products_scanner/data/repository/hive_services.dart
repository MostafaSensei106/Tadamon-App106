import 'package:hive/hive.dart';
import 'package:tadamon/core/widget/app_toast/app_toast.dart';
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
    try {
      var box = await Hive.openBox<HiveProductModel>(boxName);
      for (var product in await FireStoreServices().getAllProducts()) {
        var hiveProduct = HiveProductModel.fromMap(product);
        box.put(hiveProduct.serialNumber, hiveProduct);
      }
    } catch (e) {
      AppToast.showErrorToast('حدث خطأ اثناء تحميل المنتجات من قاعدة البيانات');
    }
  }


  //function to check if database is up to date and if not update it
  Future<bool> isLocalDataBaseUpToDate() async {
    try {
      var box = await Hive.openBox<HiveProductModel>(boxName);
      List<ProductModel> remoteProducts = await FireStoreServices().getAllProducts();
      List<ProductModel> localProducts = box.values.map((e) => ProductModel.fromMap(e.toMap())).toList();

      if (remoteProducts.length != localProducts.length) {
        await syncAllProductsToHive();
        return false;
      }

      for (var remoteProduct in remoteProducts) {
        if (!localProducts.any((localProduct) => localProduct.serialNumber == remoteProduct.serialNumber)) {
          await syncAllProductsToHive();
          return false;
        }
      }
      return true;
    } catch (e) {
      AppToast.showErrorToast('Error checking database synchronization');
      return false;
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
    var data = box.get(serialNumber);
    if (data != null) {
      return ProductModel.fromMap(data.toMap());
    } else {
      return ProductModel(
        serialNumber: serialNumber,
        isTrusted: false,
        productCategory: '',
        productManufacturer: '',
        productName: '',
      );
    }
  }

  // Future<bool> isLocalDataBaseUpToDate() async {
  //   List<ProductModel> products = await FireStoreServices().getAllProducts();
  //   List<ProductModel> localProducts = await HiveServices().getAllProducts();

  //   if (products.length != localProducts.length) {
  //     await HiveServices().syncAllProductsToHive();
  //   }
  // }

  /// Deletes all products from the local Hive database.
  ///
  /// Opens a Hive box with the name [boxName] and clears all products stored
  /// in the box using its [clear] method. If an error occurs, a toast is shown
  /// with the error message.
  Future<void> deleteAllLocalProducts() async {
    try {
      var box = await Hive.openBox<HiveProductModel>(boxName);
      await box.clear();
    } catch (e) {
      AppToast.showErrorToast('An error occurred while deleting products from the local database');
    }
  }

  search(String query) {}
}
