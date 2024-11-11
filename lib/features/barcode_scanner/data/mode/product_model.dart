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
}
