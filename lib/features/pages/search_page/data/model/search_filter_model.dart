class SearchFilterModel {
  final String? productName;
  final String? serialNumber;
  final String? productManufacturer;
  final String? productCategory;
  final bool? isTrusted;


  SearchFilterModel({
    this.productName,
    this.serialNumber,
    this.productManufacturer,
    this.productCategory,
    //this.productBoycottResonLink,
    this.isTrusted,
  });

  Map<String, dynamic> toMap() {
    return{
      if(productName != null) 'productName': productName,
      if(serialNumber != null) 'serialNumber': serialNumber,
      if(productManufacturer != null) 'productManufacturer': productManufacturer,
      if(productCategory != null) 'productCategory': productCategory,
      if(isTrusted != null) 'isTrusted': isTrusted,
    };
}
}
