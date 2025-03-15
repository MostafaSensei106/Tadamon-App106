import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:tadamon/core/widgets/app_toast/app_toast.dart';
import 'package:tadamon/generated/l10n.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

class ScannerManager {
  bool isNumber(String barcode) {
    final RegExp regExp = RegExp(r'^\d+$');
    return regExp.hasMatch(barcode);
  }

  Future<String> scanBarcode(BuildContext context) async {
    try {
      String? barcodeScanRes = await SimpleBarcodeScanner.scanBarcode(
        context,
        barcodeAppBar: BarcodeAppBar(
          appBarTitle: S.of(context).scanBarcode,
          centerTitle: true,
          enableBackButton: true,
          backButtonIcon: const Icon(Icons.keyboard_double_arrow_right_rounded),
        ),
        isShowFlashIcon: true,
        delayMillis: 0,
        cameraFace: CameraFace.back,
        scanFormat: ScanFormat.ONLY_BARCODE,
        scanType: ScanType.barcode,
        lineColor: '#FF0000',
        cancelButtonText: S.of(context).close,
      );
      if (barcodeScanRes == null || barcodeScanRes == '-1') {
        AppToast.showErrorToast('لم يتم قراءة اي باركود');
        return '-1';
      }

      if (!isNumber(barcodeScanRes)) {
        AppToast.showErrorToast(
            'الباركود :$barcodeScanRes غير صالح، يجب أن يكون رقمًا فقط');
        return '-404';
      }

      return barcodeScanRes;
    } catch (e) {
      'حدث خطأ أثناء قراءة الباركود: ${e.toString()}';
      return '-404';
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
        AppToast.showErrorToast('الصورة غير واضحة أو لا تحتوي على باركود ');
        return null;
      }
      if (!isNumber(barcode)) {
        AppToast.showErrorToast(
            'الباركود :$barcode غير صالح، يجب أن يكون رقمًا فقط');
        return null;
      }
      return barcode;
    } catch (e) {
      AppToast.showErrorToast('حدث خطأ أثناء تحليل الصورة: ${e.toString()}');
      return null;
    }
  }

  Future<XFile?> _pickImage() async {
    try {
      final ImagePicker imagePicker = ImagePicker();
      final XFile? image = await imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 45,
      );
      return image;
    } catch (e) {
      AppToast.showErrorToast('حدث خطأ أثناء اختيار الصورة: ${e.toString()}');
      return null;
    }
  }

  Future<String?> _getBarcodeFromImage(XFile image) async {
    try {
      final InputImage inputImage = InputImage.fromFilePath(image.path);
      final BarcodeScanner barcodeScanner = BarcodeScanner();
      final List<Barcode> barcodes =
          await barcodeScanner.processImage(inputImage);
      if (barcodes.isEmpty) {
        return null;
      }
      return barcodes.first.rawValue;
    } catch (e) {
      AppToast.showErrorToast('حدث خطأ أثناء معالجة الصورة: ${e.toString()}');
      return null;
    }
  }
}
