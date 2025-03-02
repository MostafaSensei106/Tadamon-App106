import 'package:objectbox/objectbox.dart';

@Entity()
class ProductObjectBoxModel {
  @Id()
  int id = 0;

  final String name;
  final String serialNumber;
  final String manufacture;
  final String category;
  final bool trusted;
  final String onError;

  ProductObjectBoxModel({
    required this.name,
    required this.serialNumber,
    required this.manufacture,
    required this.category,
    required this.trusted,
    required this.onError,
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

  factory ProductObjectBoxModel.fromMap(Map<String, dynamic> map) {
    return ProductObjectBoxModel(
      name: map['Name'],
      serialNumber: map['SerialNumber'],
      manufacture: map['Manufacture'],
      category: map['Category'],
      trusted: map['Trusted'],
      onError: map['onError'] ?? '',
    );
  }
  
}
