import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

class RadioSelectionTileComponent extends StatefulWidget {
  final Function(String)? onChanged;

  const RadioSelectionTileComponent({super.key, this.onChanged});

  @override
  State<RadioSelectionTileComponent> createState() =>
      _RadioSelectionTileComponentState();
}

class _RadioSelectionTileComponentState
    extends State<RadioSelectionTileComponent> {
  String selectedValue = 'لاأعرف';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius.r),
      ),
      child: ExpansionTile(
        leading: Icon(Icons.handshake_outlined),
        title: Text('الحالة'),
        subtitle: Text(selectedValue),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        enableFeedback: true,
        showTrailingIcon: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius.r),
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 0.2,
          ),
        ),
        children: [
          buildRadio('لاأعرف'),
          buildRadio('مقاطعة'),
          buildRadio('لا يدعم الكيان الصهيوني'),
        ],
      ),
    );
  }

  Widget buildRadio(String title) {
    return RadioListTile<String>(
      title: Text(title),
      value: title,
      groupValue: selectedValue,
      onChanged: (value) {
        setState(() {
          selectedValue = value!;
        });
        widget.onChanged?.call(value!);
      },
    );
  }
}
