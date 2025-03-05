import 'package:objectbox/objectbox.dart';

@Entity()
class ProductModel {
  @Id()
  int id = 0;

  String name;
  String serialNumber;
  String manufacture;
  String category;
  //String productBoycottResonLink;
  bool trusted;
  String onError;

  ProductModel({
    this.id = 0,
    required this.name,
    required this.serialNumber,
    required this.manufacture,
    required this.category,
    //required this.productBoycottResonLink,
    required this.trusted,
    this.onError = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'productName': name,
      'serialNumber': serialNumber,
      'productManufacturer': manufacture,
      'productCategory': category,
      'isTrusted': trusted,
      'onError': onError
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['productName'] ?? '',
      serialNumber: map['serialNumber'] ?? '',
      manufacture: map['productManufacturer'] ?? '',
      category: map['productCategory'] ?? '',
      trusted: map['isTrusted'] ?? false,
      onError: map['onError'] ?? '',
    );
  }
}
