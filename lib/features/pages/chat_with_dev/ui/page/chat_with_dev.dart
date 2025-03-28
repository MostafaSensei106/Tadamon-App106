import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/services/url_services/url_services.dart';
import 'package:tadamon/core/widgets/button_component/button_compnent.dart';
import 'package:tadamon/core/widgets/text_filed_component/text_filed_component.dart';
import 'package:tadamon/features/pages/chat_with_dev/ui/widget/chat_bubble.dart';

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
        'text': 'شارك التطبيق مع أصدقائك! 📲',
        'isSentByMe': false,
        'isShareApp': true
      },
    ];

    final now = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 90.w,
        titleSpacing: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            Stack(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(SenseiConst.mostafaSenseiogo),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 10.w,
                    height: 10.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.surface,
                          width: 1),
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        title: const Text(
          'Mostafa Sensei',
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            onPressed: () => UrlRunServices.launchURL(
                'tg://resolve?domain=@Mostafa_Sensei106'),
            icon: const Icon(Icons.call_outlined),
          ),
        ],
      ),
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
                  final dateTime = index == messages.length - 1
                      ? now
                      : now.subtract(const Duration(minutes: 1));
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
              padding: const EdgeInsets.all(SenseiConst.padding),
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
