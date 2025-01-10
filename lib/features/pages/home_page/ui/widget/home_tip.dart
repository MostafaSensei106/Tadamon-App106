import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/generated/l10n.dart';

class HomeTip extends StatefulWidget {
  const HomeTip({super.key});

  @override
  HomeTipState createState() => HomeTipState();
}

class HomeTipState extends State<HomeTip> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  void _onClosePressed() {
    HapticFeedback.vibrate();
    _controller.reverse().then((_) {
      setState(() {
        _controller.value = 0.0;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: SizeTransition(
        sizeFactor: _animation,
        axisAlignment: -1.0,
        child: GestureDetector(
          onDoubleTap: _onClosePressed,
          child: Container(
            margin: EdgeInsets.only(bottom: SenseiConst.margin),
            padding: const EdgeInsets.all(SenseiConst.padding),
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(SenseiConst.outBorderRadius),
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: ListTile(
              subtitleTextStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
              leading: Icon(
                Icons.lightbulb_outline_rounded,
                size: SenseiConst.iconSize,
                color: Theme.of(context).colorScheme.onSecondaryContainer,
              ),
              title: Text(
                S.of(context).AppName,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                ),
              ),
              subtitle: Text(S.of(context).AppDescription),
            ),
          ),
        ),
      ),
    );
  }
}
