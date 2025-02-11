import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadamon/core/widget/app_toast/app_toast.dart';
import 'package:tadamon/features/products_scanner/logic/logic/scanner_manger.dart';
import 'package:tadamon/features/report_products/logic/bloc/report_product_state.dart';
import 'package:tadamon/features/report_products/logic/services/report_service.dart';

class ReportProductCubit extends Cubit<ReportProductState> {
  ReportProductCubit() : super(ReportProductInitial());
  /// Returns true if both [serialNumber] and [productName] are not empty
  ///
  /// If either [serialNumber] or [productName] is empty, returns false
  bool isFormNotEmpty(String serialNumber, String productName) {
    if (serialNumber.isNotEmpty &&
        productName.isNotEmpty) {
      return true;
    }
    return false;
  }

  /// Validates the report product form inputs.
  ///
  /// If the inputs are valid, emits [ReportProductIsValid].
  ///
  /// If the inputs are invalid, emits [ReportProductIsNotValid] with the error message.
  ///
  /// The checks are as follows:
  ///
  /// - If the [productName] length is 50 or more, an error is emitted.
  /// - If the [serialNumber] does not match the regular expression [RegExp(r'^[0-9]{6,13}$')],
  ///   an error is emitted.
  ///
  /// If either of the above checks fail, an error is emitted.
  /// If both checks pass, [ReportProductIsValid] is emitted.
  void validateInputs(String serialNumber, String productName) {
    if (isFormNotEmpty(serialNumber, productName)) {
      if (productName.length >= 50) {
        emit( ReportProductProductNameIsNotValid('الاسم يجب أن يكون أقل من أو يساوى 50 حرف'));
      } else if (!RegExp(r'^[0-9]{6,13}$').hasMatch(serialNumber)) {
        emit( ReportProductSerialNumberIsNotValid('الرقم التسلسلي يجب أن يتكون من 6-13 أرقام'));
      } else {
        emit(ReportProductIsValid());
      }
    } else {
      emit(ReportProductIsNotValid());
    }
  }


  /// Scans a barcode using the [ScannerManager] and updates the [controller]'s text
  /// with the scanned barcode.
  ///
  /// If the scan is successful, the [controller]'s text is updated with the scanned
  /// barcode.
  ///
  /// If the scan fails or is cancelled, the [controller]'s text is not updated.
  ///
  /// If an error occurs while scanning the barcode, an error toast is shown with the
  /// error message and the [controller]'s text is not updated.
  Future<void> scanBarcode(
      BuildContext context, TextEditingController controller) async {
    try {
      String? resSerialNumber = await ScannerManager().scanBarcode(context);
      if (resSerialNumber != null && resSerialNumber != '-1') {
        controller.text = resSerialNumber;
      }
    } catch (e) {
      AppToast.showErrorToast(e.toString());
    }
  }


  /// Submits a product report with the given details asynchronously.
  ///
  /// The report includes:
  /// - [serialNumber]: The serial number of the product.
  /// - [productName]: The name of the product.
  /// - [status]: The status of the product report.
  /// - A timestamp of when the report was submitted.
  ///
  /// Uses [ReportService.sendProductReport] to send the report asynchronously.
  ///
  /// If an error occurs during submission, an error toast is shown with the
  /// error message.
  Future<void> submitReport(
      String serialNumber, String productName, String status ) async {
    emit(ReportProductIsLoading());
    final report = {
      'serialNumber': serialNumber,
      'productName': productName,
      'status': status,
      'timestamp': DateTime.now().toUtc().toIso8601String(),
    };
    try {
      await ReportService().sendProductReport(report);
    } catch (e) {
      AppToast.showErrorToast('حدث خطاء اثناء ارسال التقرير: $e');
    }
  }

}