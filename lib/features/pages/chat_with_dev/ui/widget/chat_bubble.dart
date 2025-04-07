import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/services/url_services/url_services.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSentByMe;
  final bool isSupportDevButton;
  final DateTime time;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isSentByMe,
    this.isSupportDevButton = false,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final formattedTime = DateFormat('hh:mm a', 'en').format(time);

    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment:
            isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isSentByMe)
            const Padding(
              padding: EdgeInsets.only(right: SenseiConst.padding),
              child: CircleAvatar(
                backgroundImage: AssetImage(SenseiConst.mostafaSenseiogo),
                radius: SenseiConst.outBorderRadius,
              ),
            ),
          Container(
            constraints: BoxConstraints(maxWidth: 0.75.sw),
            padding: const EdgeInsets.all(SenseiConst.padding),
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: isSentByMe
                  ? Theme.of(context).colorScheme.secondaryContainer
                  : Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    textBaseline: TextBaseline.alphabetic,
                    color: isSentByMe
                        ? Theme.of(context).colorScheme.onSecondaryContainer
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  formattedTime,
                  style: TextStyle(
                    fontSize: 12,
                    color: isSentByMe
                        ? Theme.of(context)
                            .colorScheme
                            .onSecondaryContainer
                            .withAlpha(0x50)
                        : Theme.of(context).colorScheme.onSurface.withAlpha(0x50),
                  ),
                ),
              ],
            ),
          ),
          if (isSupportDevButton && !isSentByMe)
            ElevatedButton(
              onPressed: () =>
                  UrlRunServices.launchURL(SenseiConst.buyMeACoffeeLink),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius),
                ),
              ),
              child: const Text('Support Tadamon'),
            ),
        ],
      ),
    );
  }
}

