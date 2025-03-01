// import 'package:hive/hive.dart';


// part 'hive_logs_product_model.g.dart';

// @HiveType(typeId: 1)
// class HiveLogsProductModel extends HiveObject {
//    @HiveField(0)
//   final String productName;

//   @HiveField(1)
//   final String serialNumber;

//   @HiveField(2)
//   final String productManufacturer;

//   @HiveField(3)
//   final String productCategory;

//   @HiveField(4)
//   final bool isTrusted;

//   @HiveField(5)
//   final String timeStamp;
  
//   @HiveField(6)
//   final String onError;

//   HiveLogsProductModel({
//     required this.serialNumber,
//     required this.productName,
//     required this.productManufacturer,
//     required this.productCategory,
//     required this.isTrusted,
//     required this.timeStamp,
//     required this.onError,
//   });



//   factory HiveLogsProductModel.create({
//     required String serialNumber,
//     required String description,
//     required String category,
//   }) {
//     return HiveLogsProductModel(
//       serialNumber: serialNumber,
//       productName: description,
//       productManufacturer: '',
//       productCategory: category,
//       isTrusted: false,
//       timeStamp: timeStamp,
//       onError: '',
//     );
//   }
// }
