class ProdectModel {
  final String name;
  final String serialNumber;
  final String manufacturer;
  final List<String> category;
  final String boycottResonLink;
  final bool trusted;

  ProdectModel({
    required this.name,
    required this.serialNumber,
    required this.manufacturer,
    required this.category,
    required this.boycottResonLink,
    required this.trusted,
  });

  factory ProdectModel.fromJson(Map<String, dynamic> json) {
    return ProdectModel(
      name: json['name'],
      serialNumber: json['serialNumber'],
      manufacturer: json['manufacturer'],
      category: List<String>.from(json['category']),
      boycottResonLink: json['boycottResonLink'],
      trusted: json['trusted'],
    );
  }
}
