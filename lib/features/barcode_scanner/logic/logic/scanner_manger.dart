import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:tadamon/core/widget/app_toast/app_toast.dart';
import 'package:tadamon/generated/l10n.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

class ScannerManager {
  Future<String?> scanBarcode(BuildContext context) async {
    try {
      final String? barcodeScanRes = await SimpleBarcodeScanner.scanBarcode(
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
        // ignore: deprecated_member_use
        lineColor: '#${Colors.yellow.value.toRadixString(16).padLeft(8, '0').toUpperCase()}',
        cancelButtonText: S.of(context).close,
      );
      if (barcodeScanRes == null || barcodeScanRes == '-1'){
        AppToast.showErrorToast('لم يتم قراءة اي باركود');
      }
      return barcodeScanRes;
    } catch (e) {
      AppToast.showErrorToast('Error occurred while scanning the barcode: ${e.toString()}');
      return null;
    }
  }

  Future<String?> imageAnalysisScan(BuildContext context) async {
    try {
      final XFile? image = await _pickImage();
      if (image == null) {
        AppToast.showErrorToast('لم يتم اختيار الصورة');
        return null;
      }
      final String? barcode = await _getBarcodeFromImage(image);
      if (barcode == null) {
        AppToast.showErrorToast('الصورة غير واضحة او لا تحتوي علي باركود');
        return null;
      }
      return barcode;
    } catch (e) {
      AppToast.showErrorToast('Error occurred while scanning the image: ${e.toString()}');
      return null;
    }
  }

  Future<XFile?> _pickImage() async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      final XFile? image = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );
      return image;
    } catch (e) {
      AppToast.showErrorToast('Error occurred while picking the image: ${e.toString()}');
      return null;
    }
  }

  Future<String?> _getBarcodeFromImage(XFile image) async {
    try {
      final InputImage inputImage = InputImage.fromFilePath(image.path);
      final BarcodeScanner barcodeScanner = BarcodeScanner();
      final List<Barcode> barcodes = await barcodeScanner.processImage(inputImage);

      if (barcodes.isEmpty) {
        return null;
      }

      return barcodes.first.rawValue;
    } catch (e) {
      AppToast.showErrorToast('Error occurred while processing the image: ${e.toString()}');
      return null;
    }
  }
}