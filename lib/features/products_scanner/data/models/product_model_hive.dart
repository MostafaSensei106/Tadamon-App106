import 'package:hive/hive.dart';
import 'product_model.dart';


part 'product_model_hive.g.dart';

@HiveType(typeId: 0)
class HiveProductModel extends HiveObject {
  @HiveField(0)
  final String productName;

  @HiveField(1)
  final String serialNumber;

  @HiveField(2)
  final String productManufacturer;

  @HiveField(3)
  final String productCategory;

  @HiveField(4)
  final bool isTrusted;

  HiveProductModel({
    required this.productName,
    required this.serialNumber,
    required this.productManufacturer,
    required this.productCategory,
    required this.isTrusted,
  });

  factory HiveProductModel.fromProduct(ProductModel product) {
    return HiveProductModel(
      productName: product.productName,
      serialNumber: product.serialNumber,
      productManufacturer: product.productManufacturer,
      productCategory: product.productCategory,
      isTrusted: product.isTrusted,
    );
  }

  ProductModel toProduct() {
    return ProductModel(
      productName: productName,
      serialNumber: serialNumber,
      productManufacturer: productManufacturer,
      productCategory: productCategory,
      isTrusted: isTrusted,
    );
  }
}
