import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widgets/text_filed_component/text_filed_component.dart';
import 'package:tadamon/features/pages/chat_with_dev/ui/widget/chat_bubble.dart';
import 'package:tadamon/features/pages/chat_with_dev/ui/widget/chat_dev_app_bar.dart';
import 'package:tadamon/generated/l10n.dart';

class ChatWithDev extends StatelessWidget {
  const ChatWithDev({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> messages = [
  {
    'text': 'شكرًا لاستخدامك هذا التطبيق! 🎉',
    'isSentByMe': false,
  },
  {
    'text': 'إذا عجبك التطبيق، يسعدنا دعمك عشان نقدر نستمر في تطويره! ❤️',
    'isSentByMe': false,
  },
  {
    'text' : 'للاستفسار، يمكنك التواصل معنا على الواتساب 👇',
    'isSentByMe': true,
  },
  {
    'text': 'تقدر تتابعنا وتدعمنا على وسائل التواصل 👇',
    'isSentByMe': false,
  },
  {
    'text': '📌 تابعنا على لمزيد من التحديثات والدعم 🙌',
    'isSentByMe': false,
  },
  {
    'text': 'وشارك التطبيق مع أصدقائك! 📲',
    'isSentByMe': false,
    'isShareApp': true,
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
                      useOutBorderRadius: true,
                      hint: '...اكتب رسالة',
                      suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.send_outlined)),
                    ),
                  ),
                  const SizedBox(width: SenseiConst.margin),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
