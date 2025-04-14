import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widgets/bottom_sheet/ui/model_bottom_sheet.dart';
import 'package:tadamon/core/widgets/button_component/button_compnent.dart';
import 'package:tadamon/core/widgets/text_filed_component/text_filed_component.dart';
import 'package:tadamon/generated/l10n.dart';
class EditTextSheetContent extends StatefulWidget {
  const EditTextSheetContent({super.key});

  @override
  State<EditTextSheetContent> createState() => _EditTextSheetContentState();

  static void showEditTextBottomSheet(BuildContext context) {
    ModelBottomSheet.show(
      context,
      S.of(context).editText,
      child: const EditTextSheetContent(),
    );
  }
}

class _EditTextSheetContentState extends State<EditTextSheetContent> {
  final TextEditingController _controller = TextEditingController();
  String _processedText = '';

  /// Removes dots from Arabic characters in the input text.
  String removeArabicDots(String text) {
    // Define a map of Arabic characters with dots and their dotless equivalents
    const Map<String, String> arabicLetters = {
      // Isolated forms
      'ب': 'ٮ', 'ت': 'ٮ', 'ث': 'ٮ', 'ج': 'ح', 'خ': 'ح', 'ذ': 'د', 'ز': 'ر',
      'ش': 'س', 'ض': 'ص', 'ظ': 'ط', 'غ': 'ع', 'ف': 'ڡ', 'ق': 'ٯ', 'ن': 'ٮ',

      // Initial forms
      'ﺑ': 'ٮ', 'ﺗ': 'ٮ', 'ﺛ': 'ٮ', 'ﺟ': 'ﺣ', 'ﺧ': 'ﺣ', 'ﺷ': 'ﺳ', 'ﺿ': 'ﺻ',
      'ﻇ': 'ﻁ', 'ﻏ': 'ﻋ', 'ﻓ': 'ﻑ', 'ﻗ': 'ٯ', 'ﻧ': 'ٮ', 'ﻳ': 'ﻯ',

      // Medial forms
      'ﺒ': 'ٮ', 'ﺘ': 'ٮ', 'ﺜ': 'ٮ', 'ﺠ': 'ﺤ', 'ﺨ': 'ﺤ', 'ﺸ': 'ﺴ', 'ﻀ': 'ﺼ',
      'ﻆ': 'ﻄ', 'ﻐ': 'ﻌ', 'ﻔ': 'ﻑ', 'ﻘ': 'ٯ', 'ﻨ': 'ٮ', 'ﻴ': 'ﻰ',

      // Final forms
      'ﺐ': 'ٮ', 'ﺖ': 'ٮ', 'ﺚ': 'ٮ', 'ﺞ': 'ﺢ', 'ﺦ': 'ﺢ', 'ﺶ': 'ﺲ', 'ﺾ': 'ﺺ',
      'ﻎ': 'ﻊ', 'ﻒ': 'ﻑ', 'ﻖ': 'ٯ', 'ﻦ': 'ٮ', 'ﻲ': 'ﻯ',

      // Special cases
      'ﻻ': 'ﻻ', 'ﻷ': 'ﻻ', 'ﻹ': 'ﻻ', 'ﻵ': 'ﻻ', 'ل': 'ل', 'لل': 'ل', 'للا': 'ل',

      // Additional letters
      'ا': 'ا', 'أ': 'ا', 'إ': 'ا', 'آ': 'ا', 'ء': 'ء', 'ؤ': 'و', 'ئ': 'ي',
      'ى': 'ي', 'ة': 'ه', 'و': 'و', 'ه': 'ه', 'ي': 'ي',
    };

    // Replace each character in the text using the map
    StringBuffer buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      String char = text[i];
      buffer.write(arabicLetters.containsKey(char) ? arabicLetters[char] : char);
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
    HapticFeedback.vibrate();
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
                    HapticFeedback.vibrate();
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
        SizedBox(
          width: 1.sw,
          child: ButtonCompnent(
            useInBorderRadius: true,
              label: 'نسخ', icon: Icons.copy, onPressed: _copyToClipboard),
        ),
      ],
    );
  }
}