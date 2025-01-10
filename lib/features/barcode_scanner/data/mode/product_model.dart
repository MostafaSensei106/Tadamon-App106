class ProductModel {
  final String? productName;
  final String serialNumber;
  final String? productManufacturer;
  final String? productCategory;
  //final String? productBoycottResonLink;
  final bool? isTrusted;
  final String? onError;

  ProductModel({
     this.productName,
    required this.serialNumber,
     this.productManufacturer,
     this.productCategory,
     //this.productBoycottResonLink,
     this.isTrusted,
     this.onError,
  });

  Map<String, dynamic> toMap() {
    return {
      'productName': productName,
      'serialNumber': serialNumber,
      'productManufacturer': productManufacturer,
      'productCategory': productCategory,
      //'productBoycottResonLink': productBoycottResonLink,
      'isTrusted': isTrusted,
    };
  }
  
  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      productName: map['Name'],
      serialNumber: map['SerialNumber'],
      productManufacturer: map['Manufacture'],
      productCategory: map['Category'],
      //productBoycottResonLink: map['productBoycottResonLink'],
      isTrusted: map['Trusted'],
    );
  }

 

}
