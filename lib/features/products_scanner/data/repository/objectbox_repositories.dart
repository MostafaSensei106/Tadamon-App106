import 'package:tadamon/core/services/object_box_services/object_box_service.dart';
import 'package:tadamon/core/widget/app_toast/app_toast.dart';
import 'package:tadamon/features/pages/log_page/data/models/scanned_logs_product_model.dart';
import 'package:tadamon/features/products_scanner/data/models/product_model.dart';
import 'package:tadamon/features/products_scanner/data/repository/fire_store_repositories.dart';

class ObjectboxRepositories {
  Future<void> syncAllProductsToLocalDB() async {
    try {
      final List<ProductModel> products =
          await FireStoreRepositorie().downloadAllProductsFromFirebase();
      ObjectBoxService.instance.tadamonProductsBox.putMany(products);
    } catch (e) {
      AppToast.showErrorToast('حدث خطأ أثناء تحميل المنتجات من قاعدة البيانات');
    }
  }

//   Future<bool> isLocalDataBaseUpToDate() async {
//     try {
//       var box = await Hive.openBox<HiveProductModel>(boxName);
//       List<ProductModel> remoteProducts =
//           await FireStoreServices().getAllProducts();
//       List<ProductModel> localProducts =
//           box.values.map((e) => ProductModel.fromMap(e.toMap())).toList();

//       if (remoteProducts.length != localProducts.length) {
//         await syncAllProductsToHive();
//         return false;
//       }

//       for (var remoteProduct in remoteProducts) {
//         if (!localProducts.any((localProduct) =>
//             localProduct.serialNumber == remoteProduct.serialNumber)) {
//           await syncAllProductsToHive();
//           return false;
//         }
//       }
//       return true;
//     } catch (e) {
//       AppToast.showErrorToast('Error checking database synchronization');
//       return false;
//     }
//   }

  Future<bool> tadamonProductsBoxHasData() async {
    var box = ObjectBoxService.instance.tadamonProductsBox.getAll();
    return box.isNotEmpty;
  }

  Future<bool> tadamonLogsBoxHasData() async {
    var box = ObjectBoxService.instance.tadamonLogsBox.getAll();
    return box.isNotEmpty;
  }

  Future<dynamic> getTadamonProductBySerialNumber(
      String serialNumber) async {
    var box = ObjectBoxService.instance.tadamonProductsBox.getAll();
    try {
      var data =
          box.firstWhere((element) => element.serialNumber == serialNumber,
              orElse: () => ProductModel(
                    name: 'غير موجود',
                    serialNumber: serialNumber,
                    manufacture: ' غير معروف المصنع',
                    category: 'غير معروف',
                    trusted: false,
                    onError: 'Product not found',
                  ));
      return ProductModel.fromMap(data.toMap());
    } catch (e) {
      AppToast.showErrorToast('Error in getTadamonProductBySerialNumber :$e');

    }
  }

  Future<void> deleteAllTadamonProductsFromLocalDB() async {
    try {
      ObjectBoxService.instance.tadamonProductsBox.removeAll();
    } catch (e) {
      AppToast.showErrorToast(
          'An error occurred while deleting products from the local database');
    }
  }

  Future<void> deleteAllTadamonLogsFromLocalDB() async {
    try {
      if (ObjectBoxService.instance.tadamonLogsBox.isEmpty()) {
        AppToast.showErrorToast('NO DATA TO BE CLEARED');
      } else {
        ObjectBoxService.instance.tadamonLogsBox.removeAll();
        AppToast.showSuccessToast('DATA HAS BEEN DELETED');
      }
    } catch (e) {
      AppToast.showErrorToast(
          'An error occurred while deleting Logs from the local database');
    }
  }

  Future<void> saveProductToTadamonLogs(ScannedLogsProductModel product) async {
    try {
      ObjectBoxService.instance.tadamonLogsBox.put(product);
    } catch (e) {
      AppToast.showErrorToast('An error occurred while saving the product: $e');
    }
  }





//   Future<void> saveProductToHiveLogs(ProductModel product) async {
//     try {
//       var box = await Hive.openBox<HiveProductModel>(logsBoxName);
//       var hiveProduct = HiveProductModel.fromMap(product);
//       await box.put(hiveProduct.serialNumber, hiveProduct);
//     } catch (e) {
//       AppToast.showErrorToast('An error occurred while saving the product: $e');
//     }
//   }

//   Future<void> clearLogs() async {
//     var box = await Hive.openBox<HiveProductModel>(logsBoxName);
//     if (box.isNotEmpty) {
//       await box.clear();
//       AppToast.showToast('Logs cleared successfully');
//     } else {
//       AppToast.showToast('There are no logs to be cleared');
//     }
//   }

//   Future<List<HiveProductModel>> getLogs() async {
//     var box = await Hive.openBox<HiveProductModel>(logsBoxName);
//     return box.values.toList();
//   }

//    Future<List<HiveProductModel>> searchLogs(String query, String filter) async {
//     final logs = await getLogs();
//     return logs.where((log) {
//       bool matchesQuery = log.serialNumber.toLowerCase().contains(query.toLowerCase());
//       if (filter.isNotEmpty) {
//         return matchesQuery && log.productCategory == filter;
//       }
//       return matchesQuery;
//     }).toList();
//   }

// }
}
