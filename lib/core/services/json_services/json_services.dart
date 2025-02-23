import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:tadamon/core/widget/app_toast/app_toast.dart';
import 'package:tadamon/features/products_scanner/data/models/product_model.dart';

class JsonServices {
  Future<void> saveProductsToJSON(List<ProductModel> products) async {
    final directory = await path_provider.getExternalStorageDirectory();
    final file = File('${directory!.path}/Tadamon/products.json');
    final jsonList = products.map((product) => product.toMap()).toList();
    final jsonString = jsonEncode(jsonList);
    await file.writeAsString(jsonString);
    AppToast.showToast('Products saved to JSON successfully');
  }
  
}
