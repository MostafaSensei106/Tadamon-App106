import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widget/button_component/button_compnent.dart';
import 'package:tadamon/core/widget/text_filed_component/text_filed_component.dart';
import 'package:tadamon/features/app_toast/app_toast.dart';
import 'package:tadamon/features/barcode_scanner/logic/logic/scanner_manger.dart';
import 'package:tadamon/features/report_products/logic/services/report_service.dart';
import 'package:tadamon/features/report_products/widgets/report_products_seet_content/radio_selection_tile_component.dart';

class ReportProductSheetContent extends StatefulWidget {
  const ReportProductSheetContent({super.key});

  @override
  State<ReportProductSheetContent> createState() =>
      _ReportProductSheetContentState();
}

class _ReportProductSheetContentState extends State<ReportProductSheetContent> {
  final serialNumberController = TextEditingController();

  final productNameController = TextEditingController();

  String status = 'لا أعرف';

  bool isFormValid = false;

  @override
  void initState() {
    super.initState();
    serialNumberController.addListener(() {
      _validateForm();
    });
    productNameController.addListener(() {
      _validateForm();
    });
  }

  /// Validates the form by checking if both the serial number and product name
  /// controllers are not empty. If both are not empty, the [isFormValid] state
  /// variable is set to true. Otherwise, it is set to false. The state is
  /// updated using [setState] to trigger a rebuild of the widget tree when the
  /// form is validated.
  void _validateForm() {
    setState(() {
      isFormValid = serialNumberController.text.isNotEmpty &&
          productNameController.text.isNotEmpty;
    });
  }

  /// Scans the barcode using the device's camera and sets the scanned serial number
  /// to the [serialNumberController].
  ///
  /// If the scan is successful, the scanned serial number is set to the
  /// [serialNumberController]. If the scan failed or was cancelled, the method
  /// returns without doing anything.
  ///
  /// If an error occurred while scanning the barcode, an error toast is displayed
  /// with the error message, and the method returns without doing anything.
  Future<void> _scanBarcode(BuildContext context) async {
    try {
      String? resSerialNumber = await ScannerManager().scanBarcode(context);
      if (!context.mounted ||
          resSerialNumber == null ||
          resSerialNumber == '-1') {
        return;
      }
      serialNumberController.text = resSerialNumber;
    } catch (e) {
      AppToast.showErrorToast(e.toString());
    }
  }

  /// Submits the report to the FireStore database and pops the bottom sheet.
  ///
  /// The report is constructed from the [serialNumberController] and
  /// [productNameController] and the selected [status]. The timestamp of the
  /// report is set to the current time using [Timestamp.now].
  ///
  /// If the report is submitted successfully, the bottom sheet is popped. If an
  /// error occurs, an error toast is displayed with the error message.
  void submitReport(BuildContext context) async {
    final report = {
      'serialNumber': serialNumberController.text,
      'productName': productNameController.text,
      'status': status,
      'timestamp': Timestamp.now(),
    };

    try {
      Navigator.pop(context);
      await ReportService().sendProductReport(report);
    } catch (e) {
      AppToast.showErrorToast('حدث خطأ أثناء إرسال التقرير: $e');
    }
  }

  @override
  /// Builds a bottom sheet content with a form to report a product.
  ///
  /// The form has two text fields: the first is for the serial number of the
  /// product, and the second is for the product name. The serial number field
  /// has a numeric keyboard and a button to scan the barcode of the product.
  /// The product name field has a label keyboard.
  ///
  /// The form also has a radio selection tile with two options: 'مقاطعة' and
  /// 'لا يدعم الكيان'. The selected value is stored in the [status] variable.
  ///
  /// The form is validated by checking if both the serial number and product name
  /// fields are not empty. If both are not empty, the [isFormValid] state
  /// variable is set to true. Otherwise, it is set to false. The state is
  /// updated using [setState] to trigger a rebuild of the widget tree when the
  /// form is validated.
  ///
  /// The form also has a button to submit the report. The button is disabled if
  /// the form is not valid. When the button is pressed, the [submitReport] method
  /// is called with the [context] as an argument.
  Widget build(BuildContext context) {
    return Column(children: [
      TextFiledComponent(
        controller: serialNumberController,
        icon: Icons.qr_code_rounded,
        isNumeric: true,
        hint: 'ادخل رقم التسلسلي',
        errorText: 'الرقم التسلسلي مطلوب',
        suffixIcon: IconButton(
          icon: const Icon(Icons.camera_alt_outlined),
          onPressed: () => _scanBarcode(context),
        ),
      ),
      SizedBox(
        height: SenseiConst.margin.h,
      ),
      TextFiledComponent(
        controller: productNameController,
        icon: Icons.label_outline_rounded,
        hint: 'ادخل اسم المنتج',
        errorText: 'اسم المنتج مطلوب',
      ),
      SizedBox(
        height: SenseiConst.margin.h,
      ),
      RadioSelectionTileComponent(
        onChanged: (value) {
          status = value;
        },
      ),
      SizedBox(
        height: SenseiConst.margin.h,
      ),
      ButtonCompnent(
          label: 'ارسال بالتقرير',
          icon: Icons.send,
          onPressed: isFormValid ? () => submitReport(context) : null),
    ]);
  }


  @override
  /// Disposes of the text controllers and calls [super.dispose].
  ///
  /// This is called when the widget is removed from the tree.
  ///
  /// It is important to call [dispose] to free up resources when the widget
  /// is no longer needed.
  void dispose() {
    serialNumberController.removeListener(() {});
    productNameController.removeListener(() {});
    serialNumberController.dispose();
    productNameController.dispose();
    super.dispose();
  }
}
