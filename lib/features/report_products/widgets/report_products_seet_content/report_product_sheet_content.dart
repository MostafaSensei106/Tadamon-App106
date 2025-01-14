import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widget/app_toast/app_toast.dart';
import 'package:tadamon/core/widget/button_component/button_compnent.dart';
import 'package:tadamon/core/widget/text_filed_component/text_filed_component.dart';
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

   String serialNumberErrorText = '';
  String productNameErrorText = '';

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

  void _validateForm() {
    setState(() {
      isFormValid = serialNumberController.text.isNotEmpty &&
          productNameController.text.isNotEmpty;
    });
  }

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

  void submitReport(BuildContext context) async {
     setState(() {
      serialNumberErrorText =
          serialNumberController.text.isEmpty ? 'رقم التسلسلي مطلوب' : '';
      productNameErrorText =
          productNameController.text.isEmpty ? 'اسم المنتج مطلوب' : '';
    });
    if (!isFormValid) {
      serialNumberErrorText = 'الرقم التسلسلي مطلوب';
      productNameErrorText = 'اسم المنتج مطلوب';
          return;
    }
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
  Widget build(BuildContext context) {
    return Column(children: [
      TextFiledComponent(
        controller: serialNumberController,
        icon: Icons.qr_code_rounded,
        isNumeric: true,
        hint: 'ادخل رقم التسلسلي',
        errorText: serialNumberErrorText,
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
        errorText: productNameErrorText,
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
          onPressed: isFormValid ? () => submitReport(context) : null
          ),
    ]);
  }

  /// Disposes of the [serialNumberController] and [productNameController].
  ///
  /// This should be called when the widget is no longer needed.
  @override
  void dispose() {
    serialNumberController.dispose();
    productNameController.dispose();
    super.dispose();
  }
}
