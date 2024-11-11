import 'package:flutter/material.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:tadamon/generated/l10n.dart';

class ScanerManger {
  Future<String> scanBarcode(BuildContext context) async {
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
      lineColor:
          '#${Colors.yellow.value.toRadixString(16).padLeft(8, '0').toUpperCase()}',
      cancelButtonText: S.of(context).close,
    );

    if (barcodeScanRes == null) {
      return '';
    }

    return barcodeScanRes;
  }
}
