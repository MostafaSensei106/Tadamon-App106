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
  /// Returns a [Container] widget with a [ExpansionTile] widget as child.
  /// The [ExpansionTile] widget has a rounded border with the
  /// [SenseiConst.inBorderRadius] radius, and a background color of
  /// [Theme.of(context).colorScheme.surfaceContainer]. The [ExpansionTile] widget
  /// also has a thin border with a color of
  /// [Theme.of(context).colorScheme.primary] with an alpha of 0.2.
  /// The [ExpansionTile] widget has an [Icon] widget with the
  /// [Icons.handshake_outlined] icon as the leading widget, and a [Text] widget
  /// with the text "الحالة" as the title. The subtitle of the
  /// [ExpansionTile] widget is a [Text] widget with the text of the selected
  /// value. The [ExpansionTile] widget has three [RadioListTile] widgets as
  /// children, which are configured with the given titles. When the
  /// [ExpansionTile] widget is tapped, [HapticFeedback.vibrate] is called.
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

  /// Returns a [RadioListTile] widget with the given title.
  ///
  /// The [RadioListTile] widget has a [Text] widget as title, which is
  /// configured with the given title. The [RadioListTile] widget also has a
  /// value of the given title, and a group value of [selectedValue].
  /// When the [RadioListTile] widget is changed, the [selectedValue] is updated
  /// with the new value, and the [onChanged] callback of the
  /// [RadioSelectionTileComponent] is called with the new value.
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
