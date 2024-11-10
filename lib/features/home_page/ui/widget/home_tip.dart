import 'package:flutter/material.dart';
import 'package:tadamon_app/core/config/const/sensei_const.dart';
import 'package:tadamon_app/generated/l10n.dart';

class HomeTip extends StatefulWidget {
  const HomeTip({super.key});

  @override
  _HomeTipState createState() => _HomeTipState();
}

class _HomeTipState extends State<HomeTip> with SingleTickerProviderStateMixin {
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
        child: Container(
          padding: const EdgeInsets.all(SenseiConst.padding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius),
            color: Theme.of(context).colorScheme.tertiaryContainer,
          ),
          child: ListTile(
            subtitleTextStyle: TextStyle(
              color: Theme.of(context).colorScheme.onTertiaryContainer,
            ),
            leading: Icon(
              Icons.lightbulb_outline_rounded,
              size: SenseiConst.iconSize,
              color: Theme.of(context).colorScheme.onTertiaryContainer,
            ),
            title: Text(
              S.of(context).AppName,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onTertiaryContainer,
              ),
            ),
            subtitle: Text(S.of(context).AppDescription),
            trailing: IconButton(
              onPressed: _onClosePressed,
              icon: Icon(
                Icons.close,
                size: SenseiConst.iconSize,
                color: Theme.of(context).colorScheme.onTertiaryContainer,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
