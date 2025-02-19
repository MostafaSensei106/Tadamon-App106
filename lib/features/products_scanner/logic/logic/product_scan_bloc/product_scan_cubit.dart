import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tadamon/core/controller/network_controller/network_controller.dart';
import 'package:tadamon/core/widget/bottom_sheet/ui/model_bottom_sheet.dart';
import 'package:tadamon/features/products_scanner/data/models/product_model.dart';
import 'package:tadamon/features/products_scanner/data/repository/fire_store_services.dart';
import 'package:tadamon/features/products_scanner/data/repository/hive_services.dart';
import 'package:tadamon/features/products_scanner/logic/logic/scanner_manger.dart';
import 'package:tadamon/features/products_scanner/ui/widget/product_list_view.dart';
import 'package:tadamon/generated/l10n.dart';

part 'product_scan_state.dart';

class ProductScanCubit extends Cubit<ProductScanState> {
  ProductScanCubit() : super(ProductScanInitial());

  /// Shows a bottom sheet with the product info.
  ///
  /// [context] is the build context of the widget that calls this method.
  ///
  /// [product] is the product info to be displayed.
  ///
  /// This method is private and should not be called directly.
  void _showProductInfo(BuildContext context, ProductModel product,  ) {
    if (!context.mounted) return;
    ModelBottomSheet.show(
      context,
      S.of(context).SheetTitleProductInfo,
      child: ProductListView(product: product,),
    );
  }

  /// Scans a barcode using the camera and shows a bottom sheet with the product info.
  ///
  /// If the scan is successful, the product info is retrieved from Firestore if the
  /// device is connected to the internet, or from the local Hive database if it is
  /// not. The product info is then displayed in a bottom sheet.
  ///
  /// If the scan fails or the product is not found, an error toast is shown with the
  /// error message.
  ///
  /// [context] is the build context of the widget that calls this method.
  ///
  /// This method is asynchronous and returns a [Future<void>].
  Future<void> scanBarcodeCamera(BuildContext context) async {
    HapticFeedback.vibrate();

    ProductModel product;

    try {
      String? scanResult = await ScannerManager().scanBarcode(context);

      if (scanResult == null || scanResult == "-1") {
        return;
      }
      bool isConnected = await NetworkController().checkConnection();

      emit(ProductScanLoading());

      if (isConnected) {
        product =
            await FireStoreServices().getProductBySerialNumber(scanResult);
      } else {
        product = await HiveServices().getProductBySerialNumber(scanResult);
      }
      if (context.mounted) {
        _showProductInfo(context, product,);
        emit(ProductScanSuccess());
      }
    } catch (e) {
      debugPrint("Error in scanBarcodeCamera: $e");
    }
  }

  Future<void> imageAnalysisScan(BuildContext context) async {
    HapticFeedback.vibrate();
    bool isConnected = await NetworkController().checkConnection();
    ProductModel product;
    try {
      if (!context.mounted) return;
      String? scanResult = await ScannerManager().imageAnalysisScan(context);
      if (!context.mounted || scanResult == null) return;
      if (isConnected) {
        product =
            await FireStoreServices().getProductBySerialNumber(scanResult);
      } else {
        product = await HiveServices().getProductBySerialNumber(scanResult);
      }
      if (!context.mounted) return;
      _showProductInfo(context, product);
      emit(ProductScanSuccess());
    } catch (e) {
      debugPrint("Error in imageAnalysisScan: $e");
    }
  }
}
