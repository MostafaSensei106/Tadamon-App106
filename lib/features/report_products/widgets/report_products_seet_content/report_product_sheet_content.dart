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
  final _formKey = GlobalKey<FormState>();

  final serialNumberController = TextEditingController();

  final productNameController = TextEditingController();

  String _status = 'لا أعرف';

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
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => Center(
              child: CircularProgressIndicator(),
            ));
    if (_formKey.currentState!.validate()) {
      final report = {
        'serialNumber': serialNumberController.text,
        'productName': productNameController.text,
        'status': _status,
        'timestamp': Timestamp.now(),
      };
      await ReportService().sendProductReport(report);
    }else{
      Navigator.pop(context);
    }
  }

  @override
  /// A widget that contains form to report a product.
  ///
  /// It contains four parts:
  ///
  /// 1. A [TextFiledComponent] to enter the product serial number.
  ///
  /// 2. A [TextFiledComponent] to enter the product name.
  ///
  /// 3. A [DropDownComponent] to select the product status.
  ///
  /// 4. A [ButtonCompnent] to send the report.
  ///
  /// When the button is pressed, it pops the current route and shows a success
  /// toast to indicate that the report has been sent successfully.
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
        isRequired: false,
        hint: 'ادخل اسم المنتج',
        errorText: 'اسم المنتج مطلوب',
      ),
      SizedBox(
        height: SenseiConst.margin.h,
      ),
      RadioSelectionTileComponent(
        onChanged: (value) {
          _status = value;
        },
      ),
      SizedBox(
        height: SenseiConst.margin.h,
      ),
      ButtonCompnent(
          label: 'ارسال بالتقرير',
          icon: Icons.send,
          onPressed: () {
            submitReport(context);
          })
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
