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
  /// Shows a bottom sheet with the title translated to "Edit Text" and a
  /// [EditTextSheetContent] as its child in the given [context].
  ///
  /// The bottom sheet is scrollable, has a top border radius of 14 logical
  /// pixels, uses the root navigator, and is dismissible.
  ///
  /// The [EditTextSheetContent] is displayed within a [ClipRRect] with a
  /// circular corner radius of 14 logical pixels.
  ///
  /// The [EditTextSheetContent] is wrapped in a [Column] with a [Padding]
  /// widget to add horizontal padding and a [Wrap] widget to stack the title
  /// and the child vertically.
  ///
  /// The [EditTextSheetContent] is also wrapped in a [SingleChildScrollView]
  /// to make the bottom sheet scrollable.
  ///
  /// The [EditTextSheetContent] is displayed at the bottom of the screen with
  /// a padding of 16 logical pixels.
  ///
  /// The [EditTextSheetContent] is also padded with a [Padding] widget to add
  /// a bottom padding of 16 logical pixels.
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
  /// Replaces Arabic letters with their corresponding letters without dots.
  ///
  /// This is useful for searching and matching Arabic text because some
  /// Arabic letters have dots and some do not.
  ///
  /// The Arabic letters with dots are:
  /// - ب (ba with dot) => ٮ (ba without dot)
  /// - ت (te with dot) => ٮ (te without dot)
  /// - ث (thal with dot) => ٮ (thal without dot)
  /// - ج (jim with dot) => ح (hah with dot)
  /// - خ (kha with dot) => ح (hah with dot)
  /// - ذ (dhal with dot) => د (dal without dot)
  /// - ز (zay with dot) => ر (ra without dot)
  /// - ش (shin with dot) => س (sin without dot)
  /// - ض (dad with dot) => ص (sad without dot)
  /// - ظ (zay with dot) => ط (te without dot)
  /// - غ (ghayn with dot) => ع (ayn without dot)
  /// - ف (fa with dot) => ڡ (fa without dot)
  /// - ق (qaf with dot) =>  (qaf without dot)
  /// - ن (nun with dot) =>  (nun without dot)
  /// - ي (ya with dot) =>  (ya without dot)
  ///
  /// The function also replaces the Arabic letters without dots with their
  /// corresponding letters with dots.
  ///
  /// The function returns a new string with the replaced letters.
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

  /// Sets the [_processedText] to the result of calling [removeArabicDots] on
  /// the given [text].
  ///
  /// This function is used as the [onChange] callback for the text field used
  /// to input the text to be processed. The processed text is then used in a
  /// read only text field to display the result.
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
  /// Builds a column of a text field to input the text to be processed, a read
  /// only text field to display the result of calling [removeArabicDots] on the
  /// input text, and a button to copy the result to the device's clipboard.
  ///
  /// The input text field uses the [TextFieldComponent] widget with the
  /// [onChange] callback set to [_processText], which sets the [_processedText]
  /// to the result of calling [removeArabicDots] on the input text.
  ///
  /// The result text field uses the [TextFieldComponent] widget with the
  /// [controller] set to a [TextEditingController] with the [_processedText] as
  /// the initial text, and the [readOnly] property set to true.
  ///
  /// The copy button uses the [ButtonCompnent] widget with the [label] set to
  /// 'نسخ', the [icon] set to [Icons.copy], and the [onPressed] callback set to
  /// [_copyToClipboard], which copies the [_processedText] to the device's
  /// clipboard.
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
