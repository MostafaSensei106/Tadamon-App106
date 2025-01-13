import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widget/bottom_sheet/widget/bottom_model_sheet_content.dart';
import 'package:tadamon/core/widget/bottom_sheet/widget/sheet_header.dart';
import 'package:tadamon/generated/l10n.dart';

class ModelBottomSheet {
  static void show(BuildContext context, String title,
      {required Widget child}) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      useRootNavigator: true,
      isDismissible: true,
      builder: (context) => _buildBottomSheet(context, title, child),
    );
  }

  static Widget _buildBottomSheet(
      BuildContext context, String title, Widget child) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(14.r)),
      child: ColoredBox(
        color: Theme.of(context).colorScheme.surface,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Wrap(
              children: [
                BottomSheetHeader(titile: title),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: SenseiConst.padding.w),
                  child: Column(
                    children: [
                      BottomModelSheetContent(
                        child: child,
                      ),
                      _buildCloseButton(context),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildCloseButton(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          style: ButtonStyle(
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(SenseiConst.inBorderRadius.r),
            )),
          ),
          child: Text(S.of(context).close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
