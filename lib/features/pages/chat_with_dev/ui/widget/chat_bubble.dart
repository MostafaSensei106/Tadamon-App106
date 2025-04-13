import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widgets/button_component/button_compnent.dart';
import 'package:tadamon/features/pages/chat_with_dev/ui/widget/donation_for_dev_slider.dart';

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSentByMe;
  final bool isSupportDevButton;
  final bool isShareButton;
  final DateTime time;

  const ChatBubble({
    super.key,
    required this.text,
    required this.isSentByMe,
    this.isSupportDevButton = false,
    this.isShareButton = false,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    final formattedTime = DateFormat('hh:mm a', 'en').format(time);
    return Align(
      alignment: isSentByMe ? Alignment.bottomRight : Alignment.bottomLeft,
      child: Row(
        mainAxisAlignment:
            isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isSentByMe)
            const Padding(
              padding: EdgeInsets.only(right: SenseiConst.padding),
              child: CircleAvatar(
                backgroundImage: AssetImage(SenseiConst.mostafaSenseiogoImage),
                radius: SenseiConst.outBorderRadius,
              ),
            ),
          Container(
            constraints: BoxConstraints(maxWidth: 0.75.sw),
            padding: const EdgeInsets.symmetric(
                horizontal: SenseiConst.padding, vertical: 4.0),
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            decoration: BoxDecoration(
              color: isSentByMe
                  ? Theme.of(context).colorScheme.secondaryFixed
                  : Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius),
            ),
            child: Column(
              crossAxisAlignment: isSentByMe
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.end,
              children: [
                if (isSupportDevButton) const DonationForDevSlider(),
                Text(
                  text,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    textBaseline: TextBaseline.alphabetic,
                    color: isSentByMe
                        ? Theme.of(context).colorScheme.onSecondaryContainer
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                if (isShareButton)
                  IconButton.filledTonal(
                    onPressed: () {},
    
                    icon: const Icon(
                      Icons.share_outlined,
                      size: SenseiConst.iconSize,
                    ),
                  ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    formattedTime,
                    style: TextStyle(
                      fontSize: 12,
                      color: isSentByMe
                          ? Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer
                              .withAlpha(0x50)
                          : Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withAlpha(0x50),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
