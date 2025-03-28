import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widgets/button_component/button_compnent.dart';
import 'package:tadamon/core/widgets/text_filed_component/text_filed_component.dart';
import 'package:tadamon/features/pages/chat_with_dev/ui/widget/chat_bubble.dart';
import 'package:tadamon/features/pages/chat_with_dev/ui/widget/chat_dev_app_bar.dart';
import 'package:tadamon/generated/l10n.dart';

class ChatWithDev extends StatelessWidget {
  const ChatWithDev({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> messages = [
      {'text': 'شكرًا لاستخدامك هذا التطبيق! 🎉', 'isSentByMe': false},
      {
        'text':
            'نحن نقدر دعمك لاستمرار المشروع. إذا أحببت التطبيق، يمكنك دعمنا! ❤️',
        'isSentByMe': false
      },
      {
        'text':
            'نحن نقدر دعمك لاستمرار المشروع. إذا أحببت التطبيق، يمكنك دعمنا! ❤️',
        'isSentByMe': false
      },
      {
        'text':
            'نحن نقدر دعمك لاستمرار المشروع. إذا أحببت التطبيق، يمكنك دعمنا! ❤️',
        'isSentByMe': false
      },
      {
        'text':
            'نحن نقدر دعمك لاستمرار المشروع. إذا أحببت التطبيق، يمكنك دعمنا! ❤️',
        'isSentByMe': false
      },
      {
        'text': 'شارك التطبيق مع أصدقائك! 📲',
        'isSentByMe': false,
        'isShareApp': true
      },
    ];

    final now = DateTime.now();
    return Scaffold(
      appBar: ChatDevAppBar(title: S.of(context).mostafaMahmoud),
      body: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(SenseiConst.outBorderRadius + 7),
          topRight: Radius.circular(SenseiConst.outBorderRadius + 7),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding:
                    EdgeInsets.symmetric(horizontal: SenseiConst.padding.w),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final dateTime = now.subtract(
                    Duration(
                      minutes: (messages.length - 1 - index),
                    ),
                  );
                  return ChatBubble(
                    text: messages[index]['text'],
                    isSentByMe: messages[index]['isSentByMe'],
                    isSupportDevButton:
                        messages[index]['isSupportDevButton'] ?? false,
                    time: dateTime,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: SenseiConst.padding,
                right: SenseiConst.padding,
                bottom: SenseiConst.padding,
                top: 5,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextFieldComponent(
                      controller: TextEditingController(),
                      icon: Icons.message_outlined,
                      hint: '...اكتب رسالة',
                      onChange: (value) => {},
                    ),
                  ),
                  const SizedBox(width: SenseiConst.margin),
                  ButtonCompnent(
                    label: 'ارسال',
                    isEnabled: true,
                    useInBorderRadius: true,
                    useWidth: true,
                    width: 100.w,
                    useMargin: false,
                    onPressed: () => {},
                    icon: Icons.send_rounded,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
