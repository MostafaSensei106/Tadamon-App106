import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widget/bottom_sheet/ui/model_bottom_sheet.dart';
import 'package:tadamon/core/widget/button_component/button_compnent.dart';
import 'package:tadamon/core/widget/text_filed_component/text_filed_component.dart';
import 'package:tadamon/generated/l10n.dart';

class EditTextSheetContent extends StatefulWidget {
  const EditTextSheetContent({super.key});

  @override
  State<EditTextSheetContent> createState() => _EditTextSheetContentState();




  static void showEditTextBottomSheet(BuildContext context) {
    ModelBottomSheet.show(
      context,
      S.of(context).EditText,
      child: EditTextSheetContent(),
    );
  }
}

class _EditTextSheetContentState extends State<EditTextSheetContent> {
  final TextEditingController _controller = TextEditingController();
  String _processedText = '';
  String removeArabicDots(String text) {
    const Map<String, String> arabicLetters = {
      'ب': 'ٮ',
      'ت': 'ٮ',
      'ث': 'ٮ',
      'ج': 'ح',
      'خ': 'ح',
      'ذ': 'د',
      'ز': 'ر',
      'ش': 'س',
      'ض': 'ص',
      'ظ': 'ط',
      'غ': 'ع',
      'ف': 'ڡ',
      'ق': 'ٯ',
      'ن': 'ٮ',

      'ﺑ': 'ٮ',
      'ﺗ': 'ٮ',
      'ﺛ': 'ٮ',
      'ﺟ': 'ﺣ',
      'ﺧ': 'ﺣ',
      'ﺷ': 'ﺳ',
      'ﺿ': 'ﺻ',
      'ﻅ': 'ﻁ',
      'ﻏ': 'ﻋ',
      'ﻓ': 'ڡ',
      'ﻗ': 'ٯ',
      'ﻧ': 'ٮ',
      'ﻳ': 'ﻯ',

      'ﺒ': 'ٮ',
      'ﺘ': 'ٮ',
      'ﺜ': 'ٮ',
      'ﺠ': 'ﺤ',
      'ﺨ': 'ﺤ',
      'ﺸ': 'ﺴ',
      'ﻀ': 'ﺼ',
      'ﻆ': 'ﻄ',
      'ﻐ': 'ﻌ',
      'ﻔ': 'ڡ',
      'ﻘ': 'ٯ',
      'ﻨ': 'ٮ',
      'ﻴ': 'ﻰ',
      'ﺐ': 'ٮ',
      'ﺖ': 'ٮ',
      'ﺚ': 'ٮ',
      'ﺞ': 'ﺢ',
      'ﺦ': 'ﺢ',
      'ﺶ': 'ﺲ',
      'ﺾ': 'ﺺ',
      'ﻎ': 'ﻌ',
      'ﻒ': 'ڡ',
      'ﻖ': 'ٯ',
      'ﻦ': 'ٮ',
      'ﻲ': 'ﻯ',
      'ﻻ': 'ﻻ',
      'ﻷ': 'ﻻ',
      'ﻹ': 'ﻻ',
      'ﻵ': 'ﻻ',
      'ل': 'ل',
      'لل': 'ل',
      'للا': 'ل',
    };

    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      String char = text[i];
      buffer
          .write(arabicLetters.containsKey(char) ? arabicLetters[char] : char);
    }

    return buffer.toString();
  }



  void _processText(String text) {
    setState(() {
      _processedText = removeArabicDots(text);
    });
  }


  /// Copies the [_processedText] to the device's clipboard.
  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _processedText));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFieldComponent(
          controller: _controller,
          icon: Icons.text_fields_rounded,
          hint: 'أدخل النص',
          onChange: (value) => _processText(value),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  onPressed: () => _controller.clear(),
                  icon: const Icon(Icons.clear),
                )
              : null,
        ),
        SizedBox(height: SenseiConst.margin.h),
        TextFieldComponent(
          controller: TextEditingController(text: _processedText),
          icon: Icons.text_format,
          hint: 'النص بعد إزالة النقاط',
          largeField: true,
          onChange: (String value) {},
          readOnly: true,
          suffixIcon: _processedText.isNotEmpty
              ? IconButton(
                  onPressed: () {
                    _controller.clear();
                    setState(() {
                      _processedText = '';
                    });
                  },
                  icon: const Icon(Icons.clear),
                )
              : null,
        ),
        SizedBox(height: SenseiConst.margin.h),
        ButtonCompnent(
            label: 'نسخ', icon: Icons.copy, onPressed: _copyToClipboard),
      ],
    );
  }
}
