import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

class RadioSelectionTileComponent extends StatefulWidget {
  const RadioSelectionTileComponent({super.key});

  @override
  State<RadioSelectionTileComponent> createState() =>
      _RadioSelectionTileComponentState();
}

class _RadioSelectionTileComponentState
    extends State<RadioSelectionTileComponent> {
  String selectedValue = 'لاأعرف';

  @override

  /// Returns an [ExpansionTile] with the title 'الحالة' and three radio buttons
  /// for selecting the reason for reporting a product. The selected value is
  /// displayed as a subtitle below the radio buttons.
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
        enableFeedback:true,
        showTrailingIcon: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius.r),
          side: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 0.2,
          )
        ),
        children: [
          buildRadio('لاأعرف'),
          buildRadio('مقاطعة'),
          buildRadio('لا يدعم الكيان الصهيوني'),
        ],
      ),
    );
  }

  /// Returns a [RadioListTile] with the given [title].
  ///
  /// The selected value is displayed as a subtitle below the radio button.
  ///
  /// When the radio button is focused or unfocused, the [selectedValue]
  /// is updated to the new value.
  ///
  /// When the radio button is changed, the [selectedValue] is updated to
  /// the new value.
  Widget buildRadio(String title) {
    return RadioListTile<String>(
      title: Text(title),
      onFocusChange: (value) {
        setState(() {
          selectedValue = title;
        });
      },
      value: title,
      groupValue: selectedValue,
      onChanged: (value) {
        setState(() {
          selectedValue = value!;
        });
      },
    );
  }
}
