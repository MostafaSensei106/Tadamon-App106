import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadamon/core/helpers/extensions/date_format.dart';
import 'package:tadamon/core/widget/app_toast/app_toast.dart';
import 'package:tadamon/features/products_scanner/logic/logic/scanner_manger.dart';
import 'package:tadamon/features/report_products/logic/bloc/report_product_state.dart';
import 'package:tadamon/features/report_products/logic/services/report_service.dart';

class ReportProductCubit extends Cubit<ReportProductState> {
  ReportProductCubit() : super(ReportProductInitial());
  bool isFormNotEmpty(String serialNumber, String productName) {
    if (serialNumber.isNotEmpty &&
        productName.isNotEmpty) {
      return true;
    }
    return false;
  }


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



  Future<void> submitReport(
      String serialNumber, String productName, String status ) async {
    emit(ReportProductIsLoading());
    final report = {
      'serialNumber': serialNumber,
      'productName': productName,
      'status': status,
      'timestamp': DateTime.now().formatted
    };
    try {
      await ReportService().sendProductReport(report);
    } catch (e) {
      AppToast.showErrorToast('حدث خطاء اثناء ارسال التقرير: $e');
    }
  }

}