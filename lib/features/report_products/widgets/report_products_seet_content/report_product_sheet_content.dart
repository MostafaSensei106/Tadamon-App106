


import 'package:flutter/material.dart';
import 'package:tadamon/core/widget/button_component/button_compnent.dart';
import 'package:tadamon/core/widget/text_filed_component/text_filed_component.dart';

class ReportProductSheetContent extends StatelessWidget {
   ReportProductSheetContent({super.key});
  final serialNuberController = TextEditingController();
  final productNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFiledComponent(
          controller: serialNuberController,
          icon: Icons.numbers,
          label: 'Serial Number',
          hint: 'Enter Serial Number', errorText: 'Please Enter Serial Number',
        ),
        TextFiledComponent(
          controller: productNameController,
          icon: Icons.qr_code_rounded,
          label: 'Product Name',
          hint: 'Enter Product Name', errorText: 'Please Enter Product Name',
        ),
        ButtonCompnent(label: 'Submit', icon: Icons.send, onPressed: (){})
    ]);
  }

}