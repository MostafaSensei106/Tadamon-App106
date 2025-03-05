import 'package:tadamon/features/pages/log_page/data/models/scanned_logs_product_model.dart';
import 'package:tadamon/features/products_scanner/data/models/product_model.dart';
import 'package:tadamon/objectbox.g.dart';

class ObjectBoxService {
  static final ObjectBoxService _instance = ObjectBoxService._internal();
  late final Store store;
  late final Box<ProductModel> tadamonProductsBox;
  late final Box<ScannedLogsProductModel> tadamonLogsBox;

  ObjectBoxService._internal();

  static Future<void> init() async {
    _instance.store = await openStore();
    _instance.tadamonProductsBox = Box<ProductModel>(_instance.store);
    _instance.tadamonLogsBox = Box<ScannedLogsProductModel>(_instance.store);
  }

  static ObjectBoxService get instance => _instance;
}
