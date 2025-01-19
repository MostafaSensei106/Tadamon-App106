import 'package:tadamon/features/products_scanner/data/models/product_model.dart';

class ProductErro {
  final String serial;

ProductErro(this.serial);
  ProductModel productError() {
    return ProductModel(productName: 'غير موجود', serialNumber: serial, productManufacturer: 'غير معروف المصنع', productCategory: 'غير معروف', isTrusted: false);
  }
}