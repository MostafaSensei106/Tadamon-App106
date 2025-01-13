import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:tadamon/core/widget/app_toast/app_toast.dart';
import 'package:tadamon/generated/l10n.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

class ScannerManager {
  /// Scans the barcode using the default camera.
  ///
  /// The function returns null if an error occurs or if the user cancels the scan.
  /// Otherwise, it returns the scanned barcode as a string.
  ///
  /// The function also shows an error toast if an error occurs.
  /// The error message is 'Error occurred while scanning the barcode: [error message]'.
  ///
  Future<String?> scanBarcode(BuildContext context) async {
    try {
      final String? barcodeScanRes = await SimpleBarcodeScanner.scanBarcode(
        context,
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

  /// Scans the barcode from the selected image.
  ///
  /// This method takes a BuildContext as a parameter and returns the scanned
  /// barcode as a String. If the user cancels the image selection, or if an
  /// error occurs while scanning the image, the method returns null.
  ///
  /// The method displays an error toast if an error occurs while scanning the
  /// image. The error message is displayed in the following format: "Error
  /// occurred while scanning the image: [error message]".
  ///
  /// The method does not throw any errors. If an error occurs, the method
  /// displays an error toast and returns null.
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

  /// Picks an image from the device's gallery and returns the image as an XFile.
  ///
  /// This method takes no parameters and returns an XFile containing the picked
  /// image. If the user cancels the image selection, or if an error occurs while
  /// picking the image, the method returns null.
  ///
  /// The method displays an error toast if an error occurs while picking the
  /// image. The error message is displayed in the following format: "Error
  /// occurred while picking the image: [error message]".
  ///
  /// The method does not throw any errors. If an error occurs, the method
  /// displays an error toast and returns null.
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

  /// Extracts the barcode from the given image.
  //
  /// This method takes an image in the form of an XFile and uses the Google ML
  /// Kit's BarcodeScanner to detect the barcode in the image. If the barcode is
  /// successfully detected, the method returns the barcode's raw value. If the
  /// image does not contain a barcode, or if the method encounters an error
  /// while processing the image, the method returns null.
  //
  /// The method displays an error toast if an error occurs while processing the
  /// image. The error message is displayed in the following format: "Error
  /// occurred while processing the image: [error message]".
  //
  /// The method does not throw any errors. If an error occurs, the method
  /// displays an error toast and returns null.
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