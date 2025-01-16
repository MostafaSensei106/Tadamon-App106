import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widget/button_component/button_compnent.dart';
import 'package:tadamon/core/widget/text_filed_component/text_filed_component.dart';
import 'package:tadamon/features/report_products/logic/bloc/report_product_cubit.dart';
import 'package:tadamon/features/report_products/logic/bloc/report_product_state.dart';
import 'package:tadamon/features/report_products/widgets/report_products_seet_content/radio_selection_tile_component.dart';

class ReportProductSheetContent extends StatefulWidget {
  const ReportProductSheetContent({super.key});

  @override
  State<ReportProductSheetContent> createState() =>
      _ReportProductSheetContentState();
}

class _ReportProductSheetContentState extends State<ReportProductSheetContent> {
  final TextEditingController serialNumberController = TextEditingController();
  final TextEditingController productNameController = TextEditingController();
  String status = 'لا أعرف';

  @override
  /// A [StatefulWidget] that builds a sheet for reporting a product.
  ///
  /// The sheet contains a [TextFieldComponent] for entering the serial number
  /// of the product, another [TextFieldComponent] for entering the product name,
  /// a [RadioSelectionTileComponent] for selecting the status of the product, and
  /// a [ButtonCompnent] for submitting the report.
  ///
  /// The sheet uses a [BlocProvider] to provide the [ReportProductCubit] to its
  /// children. The [BlocBuilder] is used to listen to the state of the
  /// [ReportProductCubit] and rebuild the sheet when the state changes.
  ///
  /// The validity of the report is determined by the [ReportProductIsValid] state
  /// of the [ReportProductCubit]. If the report is valid, the button is enabled.
  /// If the report is invalid, the button is disabled and an error message is
  /// displayed.
  ///
  /// If the report is submitted successfully, the sheet is popped from the
  /// navigator.
  ///
  /// If an error occurs while submitting the report, an error message is
  /// displayed.
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReportProductCubit(),
      child: BlocBuilder<ReportProductCubit, ReportProductState>(
        builder: (context, state) {
          
          final bool isValid = state is ReportProductIsValid;
          bool isSerialNumberError = state is ReportProductSerialNumberIsNotValid;
          bool isProductNameError = state is ReportProductProductNameIsNotValid;

/// Submits the product report using the [ReportProductCubit] and closes the sheet.
/// 
/// If both the product name and serial number are invalid, the report is not submitted.
/// Upon successful submission, the sheet is popped from the navigation stack.


          void sendReport(BuildContext context) {
            if (state is ReportProductProductNameIsNotValid &&
                state is ReportProductSerialNumberIsNotValid) {
              return;
            }
            context.read<ReportProductCubit>().submitReport(
                serialNumberController.text,
                productNameController.text,
                status);
            Navigator.pop(context);
          }

          return Column(
            children: [
              TextFieldComponent(
                controller: serialNumberController,
                onChange: (_) => context
                    .read<ReportProductCubit>()
                    .validateInputs(serialNumberController.text,
                        productNameController.text),
                icon: Icons.qr_code_rounded,
                isNumeric: true,
                hint: 'ادخل الرقم التسلسلي (6-13 أرقام)',
                errorText: isSerialNumberError ? state.error : null,
                suffixIcon: IconButton(
                  icon: const Icon(Icons.camera_alt_outlined),
                  onPressed: () => context
                      .read<ReportProductCubit>()
                      .scanBarcode(context, serialNumberController),
                ),
              ),
              SizedBox(
                height: SenseiConst.margin.h,
              ),
              TextFieldComponent(
                controller: productNameController,
                onChange: (_) => context
                    .read<ReportProductCubit>()
                    .validateInputs(serialNumberController.text,
                        productNameController.text),
                icon: Icons.label_outline_rounded,
                hint: 'ادخل اسم المنتج',
                errorText: isProductNameError ? state.error : null,
              ),
              SizedBox(
                height: SenseiConst.margin.h,
              ),
              RadioSelectionTileComponent(
                onChanged: (value) {
                  setState(() {
                    status = value;
                  });
                },
              ),
              SizedBox(
                height: SenseiConst.margin.h,
              ),
              if (state is ReportProductIsLoading)
                const CircularProgressIndicator(),
              ButtonCompnent(
                label: 'ارسال التقرير',
                icon: Icons.send,
                onPressed: isValid ? () => {sendReport(context)} : null,
              ),
              if (state is ReportProductIsError)
                Text(
                  state.error,
                  style: const TextStyle(color: Colors.red),
                )
            ],
          );
        },
      ),
    );
  }
}
