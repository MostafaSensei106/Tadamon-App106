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
import 'package:tadamon/features/products_scanner/logic/logic/scanner_manger.dart';
import 'package:tadamon/features/products_scanner/ui/widget/product_list_view.dart';
import 'package:tadamon/generated/l10n.dart';

part 'product_scan_state.dart';

class ProductScanCubit extends Cubit<ProductScanState> {
  ProductScanCubit() : super(ProductScanInitial());

  void _showProductInfo(
    BuildContext context,
    ProductModel product,
  ) {
    if (!context.mounted) return;
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

  Future<void> scanBarcodeCamera(BuildContext context) async {
    HapticFeedback.vibrate();

    ProductModel product;

    try {
      String scanResult = await ScannerManager().scanBarcode(context);

      if (scanResult == '-1') {
        return;
      }

      if (scanResult == '-404') {
        return;
      }

      bool isConnected = await NetworkController().checkConnection();

      emit(ProductScanLoading());

      if (isConnected) {
        product =
            await FireStoreRepository().getProductBySerialNumber(scanResult);
      //  CounterManager.incrementScannedProducts();
      } else {
        product = await ObjectboxRepository()
            .getTadamonProductBySerialNumber(scanResult);
      //  CounterManager.incrementScannedProducts();
      }
      if (context.mounted) {
        _showProductInfo(
          context,
          product,
        );
        emit(ProductScanSuccess());
      }
    } catch (e) {
      AppToast.showErrorToast("Error in scanBarcodeCamera: $e");
    }
  }

  Future<void> imageAnalysisScan(BuildContext context) async {
    HapticFeedback.vibrate();
    ProductModel product;
    try {
      if (!context.mounted) return;
      String? scanResult = await ScannerManager().imageAnalysisScan(context);
      if (!context.mounted || scanResult == null) return;

      emit(ProductScanLoading());
      bool isConnected = await NetworkController().checkConnection();

      if (isConnected) {
        product =
            await FireStoreRepository().getProductBySerialNumber(scanResult);
       // CounterManager.incrementScannedProducts();
      } else {
        product = await ObjectboxRepository()
            .getTadamonProductBySerialNumber(scanResult);
       // CounterManager.incrementScannedProducts();
      }
      if (context.mounted) {
        _showProductInfo(context, product);
        emit(ProductScanSuccess());
      }
    } catch (e) {
      AppToast.showErrorToast("Error in imageAnalysisScan: $e");
    }
  }
}
