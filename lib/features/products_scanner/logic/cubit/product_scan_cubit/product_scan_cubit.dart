import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tadamon/core/controller/network_controller/network_controller.dart';
import 'package:tadamon/core/widgets/app_toast/app_toast.dart';
import 'package:tadamon/core/widgets/bottom_sheet/ui/model_bottom_sheet.dart';
import 'package:tadamon/features/pages/log_page/data/models/scanned_logs_product_model.dart';
import 'package:tadamon/features/products_scanner/data/models/product_model.dart';
import 'package:tadamon/features/products_scanner/data/repository/fire_store_repositories.dart';
import 'package:tadamon/features/products_scanner/data/repository/objectbox_repositories.dart';
import 'package:tadamon/features/products_scanner/logic/image_scanner.dart';
import 'package:tadamon/features/products_scanner/logic/barcode_scanner.dart';
import 'package:tadamon/features/products_scanner/ui/widget/product_list_view.dart';
import 'package:tadamon/generated/l10n.dart';

part 'product_scan_state.dart';

class ProductScanCubit extends Cubit<ProductScanState> {
  ProductScanCubit() : super(ProductScanInitial());

  /// Show a bottom sheet with the product info and save it to the local database for the user's logs.
  ///
  /// If the context is not mounted, do nothing.
  ///
  /// This is a private method, because it is not supposed to be called from outside the cubit.
  void _showProductInfo(
    BuildContext context,
    ProductModel product,
  ) {
    ModelBottomSheet.show(
      context,
      S.of(context).sheetTitleProductInfo,
      child: ProductListView(
        product: product,
      ),
    );
    ScannedLogsProductModel scannedProductToLogs =
        ScannedLogsProductModel.fromProduct(product);
    ObjectboxRepository().saveProductToTadamonLogs(scannedProductToLogs);
  }

  /// Scans a barcode using the camera.
  ///
  /// Shows a loading indicator until the operation is complete.
  ///
  /// If the barcode is not read, does nothing.
  ///
  /// If the barcode is read, shows a bottom sheet with the product info and
  /// saves it to the local database for the user's logs.
  ///
  /// If the device is connected to the internet, retrieves the product info
  /// from Firestore.
  ///
  /// If the device is not connected to the internet, retrieves the product info
  /// from the local database.
  ///
  /// If an error occurs during the operation, shows an error toast with the
  /// message "Error in scanBarcodeCamera: $e".
  Future<void> scanBarcodeByCamera(BuildContext context) async {
    HapticFeedback.vibrate();

    ProductModel product;

    try {
      emit(ProductScanLoading());

      String barcode = await BarcodeScanner().scanBarcodeByCamera(context);

      if (barcode == '-1' || barcode == '-404') {
        return;
      }

      bool isConnected = await NetworkController().checkConnection();

      if (isConnected) {
        product = await FireStoreRepository().getProductBySerialNumber(barcode);
      } else {
        product = await ObjectboxRepository()
            .getTadamonProductBySerialNumber(barcode);
      }
      if (context.mounted) {
        _showProductInfo(context, product);
        emit(ProductScanSuccess());
      }
    } catch (e) {
      AppToast.showErrorToast("Error in scanBarcodeCamera: $e");
      emit(ProductScanError(e.toString()));
    }
  }

  /// Scans a barcode from an image selected by the user.
  ///
  /// Initiates a feedback vibration and emits a loading state while the
  /// operation is in progress. It attempts to scan a barcode from an image
  /// using the [ImageScanner]. If no valid barcode is found, the method
  /// returns early with no further action.
  ///
  /// Checks network connectivity to determine the source for retrieving
  /// product information. If connected to the internet, it fetches the
  /// product information from Firestore using the scanned barcode. Otherwise,
  /// it retrieves the product information from the local database.
  ///
  /// Displays the product information in a bottom sheet and logs the product
  /// to the local database if the context is mounted. Emits a success state
  /// upon successful completion. If any error occurs during the process, an
  /// error toast is shown with the specific error message.

  Future<void> imageAnalysisScan(BuildContext context) async {
    HapticFeedback.vibrate();

    ProductModel product;

    try {
      emit(ProductScanLoading());

      String barcode = await ImageScanner().scanBarcodeFromImage(context);

      if (barcode == '-404' || barcode == '-1') return;

      bool isConnected = await NetworkController().checkConnection();

      if (isConnected) {
        product = await FireStoreRepository().getProductBySerialNumber(barcode);
      } else {
        product = await ObjectboxRepository()
            .getTadamonProductBySerialNumber(barcode);
      }
      if (context.mounted) {
        _showProductInfo(context, product);
        emit(ProductScanSuccess());
      }
    } catch (e) {
      AppToast.showErrorToast("Error in imageAnalysisScan: $e");
      emit(ProductScanError(e.toString()));
    }
  }
}
