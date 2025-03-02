class ProductModel {
  final String name;
  final String serialNumber;
  final String manufacture;
  final String category;
  //final String? productBoycottResonLink;
  final bool trusted;
  final String onError;

  const ProductModel({
    required this.name,
    required this.serialNumber,
    required this.manufacture,
    required this.category,
    //this.productBoycottResonLink,
    required this.trusted,
    this.onError = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'productName': name,
      'serialNumber': serialNumber,
      'productManufacturer': manufacture,
      'productCategory': category,
      //'productBoycottResonLink': productBoycottResonLink,
      'isTrusted': trusted,
      'onError': onError
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      name: map['Name'],
      serialNumber: map['SerialNumber'],
      manufacture: map['Manufacture'],
      category: map['Category'],
      trusted: map['Trusted'],
      onError: map['onError'] ?? '',
    );
  }
}
