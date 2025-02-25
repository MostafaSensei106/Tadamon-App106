import 'package:hive/hive.dart';
import 'package:tadamon/core/widget/app_toast/app_toast.dart';
import 'package:tadamon/features/products_scanner/data/models/product_model.dart';
import 'package:tadamon/features/products_scanner/data/models/product_model_hive.dart';
import 'package:tadamon/features/products_scanner/data/repository/fire_store_services.dart';

class HiveServices {
  static const String boxName = 'LocalTadamonProducts';
  static const String logsBoxName = 'TadamonLogs';




  Future<void> syncAllProductsToHive() async {
    try {
      var box = await Hive.openBox<HiveProductModel>(boxName);
      for (var product in await FireStoreServices().getAllProducts()) {
        var hiveProduct = HiveProductModel.fromMap(product);
        box.put(hiveProduct.serialNumber, hiveProduct);
      }
      await box.close();
    } catch (e) {
      AppToast.showErrorToast(
          'حدث خطأ اثناء تحميل المنتجات من قاعدة البيانات');
    }
  }



  Future<bool> isLocalDataBaseUpToDate() async {
    try {
      var box = await Hive.openBox<HiveProductModel>(boxName);
      List<ProductModel> remoteProducts =
          await FireStoreServices().getAllProducts();
      List<ProductModel> localProducts =
          box.values.map((e) => ProductModel.fromMap(e.toMap())).toList();

      if (remoteProducts.length != localProducts.length) {
        await syncAllProductsToHive();
        return false;
      }

      for (var remoteProduct in remoteProducts) {
        if (!localProducts.any((localProduct) =>
            localProduct.serialNumber == remoteProduct.serialNumber)) {
          await syncAllProductsToHive();
          return false;
        }
      }
      await box.close();
      return true;
    } catch (e) {
      AppToast.showErrorToast('Error checking database synchronization');
      return false;
    }
  }




  Future<bool> hiveDbHasData() async {
    var box = await Hive.openBox<HiveProductModel>(boxName);
    return box.values.isNotEmpty;
  }





  Future<dynamic> getProductBySerialNumber(String serialNumber) async {
    var box = await Hive.openBox<HiveProductModel>(boxName);
    var data = box.get(serialNumber);
    if (data != null) {
      await box.close();

      return ProductModel.fromMap(data.toMap());
    } else {
      return ProductModel(
        productName: 'غير موجود',
        serialNumber: serialNumber,
        productManufacturer: 'غير معروف المصنع',
        productCategory: 'غير معروف',
        isTrusted: false,
        onError: 'Product not found',
      );
    }
  }





  Future<void> deleteAllLocalProducts() async {
    try {
      var box = await Hive.openBox<HiveProductModel>(boxName);
      await box.clear();
      await box.close();
    } catch (e) {
      AppToast.showErrorToast(
          'An error occurred while deleting products from the local database');
    }
  }




  Future<void> saveProductToHive(ProductModel product) async {
    try {
      var box = Hive.box<HiveProductModel>(logsBoxName);
      var hiveProduct = HiveProductModel.fromMap(product);
      await box.put(hiveProduct.serialNumber, hiveProduct);
      AppToast.showToast('Product saved successfully');
    } catch (e) {
      AppToast.showErrorToast('An error occurred while saving the product');
    }
  }






  Future<void> clearLogs() async {
    var box = Hive.box<HiveProductModel>(logsBoxName);
    await box.clear();
    AppToast.showToast('Logs cleared successfully');
  }
Future<List<HiveProductModel>> getLogs() async {
    var box = Hive.box<HiveProductModel>(logsBoxName);
    return box.values.toList();
  }




  

 Future<List<HiveProductModel>> searchLogs(String query) async {
    final logs = await getLogs();
    return logs
        .where((log) => log.serialNumber.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
