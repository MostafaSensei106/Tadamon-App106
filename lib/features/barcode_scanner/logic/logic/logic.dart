import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:tadamon/core/widget/app_toast/app_toast.dart';
import 'package:tadamon/generated/l10n.dart';

class ScanerManger {
  Future<dynamic> scanBarcode(BuildContext context) async {
    String? barcodeScanRes = await SimpleBarcodeScanner.scanBarcode(
      context,
      barcodeAppBar: const BarcodeAppBar(
        appBarTitle: 'Scan Barcode',
        centerTitle: true,
        enableBackButton: true,
        backButtonIcon: Icon(Icons.arrow_back_ios),
      ),
      isShowFlashIcon: true,
      delayMillis: 0,
      cameraFace: CameraFace.back,
      scanFormat: ScanFormat.ONLY_BARCODE,
      scanType: ScanType.barcode,
      lineColor:
          // ignore: deprecated_member_use
          '#${Colors.yellow.value.toRadixString(16).padLeft(8, '0').toUpperCase()}',
      cancelButtonText: S.of(context).close,
    );

    if (barcodeScanRes == null ||
        barcodeScanRes.isEmpty ||
        barcodeScanRes == '-1') {
      AppToast.showErrorToast('لم نتمكن من قراءة الباركود');
    }
    return barcodeScanRes;
  }
}
