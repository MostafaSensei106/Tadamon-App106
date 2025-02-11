import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:tadamon/core/widget/app_toast/app_toast.dart';
import 'package:tadamon/generated/l10n.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

class ScannerManager {


  /// Scans the barcode using the default camera.
  //
  /// Shows a scanner overlay with a line color of yellow and a cancel button
  /// with the text translated as "close".
  //
  /// If the scan is successful, returns the scanned barcode as a string.
  /// If the scan failed or was cancelled, returns null.
  ///
  /// If an error occurred while scanning the barcode, shows an error toast
  /// with the error message.
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



  /// Scans a barcode from an image selected from the device's gallery.
  ///
  /// This method prompts the user to select an image from the gallery. It then
  /// attempts to extract a barcode from the selected image using image analysis.
  /// If a barcode is successfully extracted, the method returns the barcode as a
  /// string. If the image is not selected, or if no barcode is found in the
  /// image, the method returns null.
  ///
  /// If an error occurs during image selection or barcode extraction, an error
  /// toast is displayed with the error message, and the method returns null.

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

  
  
  /// Picks an image from the device's gallery.
  ///
  /// This method uses the [ImagePicker] package to prompt the user to select an
  /// image from the device's gallery. The selected image is then returned as a
  /// [XFile] object. If the user does not select an image, the method returns
  /// null.
  ///
  /// If an error occurs during image selection, an error toast is displayed with
  /// the error message, and the method returns null.
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




  /// Extracts a barcode from the provided image file.
  ///
  /// This method uses the Google ML Kit barcode scanner to extract the barcode
  /// from the image. If a barcode is found, the method returns the barcode as a
  /// string. If no barcode is found, the method returns null.
  ///
  /// If an error occurs while processing the image, an error toast is displayed
  /// with the error message, and the method returns null.
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