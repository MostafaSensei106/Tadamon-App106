import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

class CounterItemsComponent extends StatefulWidget {
  final IconData icon;
  final String title;
  final int targetValue; // The target value to animate towards

  const CounterItemsComponent({
    super.key,
    required this.icon,
    required this.title,
    required this.targetValue,
  });

  @override
  State<CounterItemsComponent> createState() => _CounterItemsComponentState();
}

class _CounterItemsComponentState extends State<CounterItemsComponent>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;
  int _currentValue = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _updateAnimation(widget.targetValue);
  }

  @override
  void didUpdateWidget(CounterItemsComponent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.targetValue != oldWidget.targetValue) {
      _updateAnimation(widget.targetValue);
    }
  }

  void _updateAnimation(int targetValue) {
    _animation =
        IntTween(begin: _currentValue, end: targetValue).animate(_controller)
          ..addListener(() {
            setState(() {
              _currentValue = _animation.value;
            });
          });

    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(SenseiConst.padding.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius),
        color: Theme.of(context).colorScheme.surfaceContainer,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(SenseiConst.padding.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius),
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Icon(
              widget.icon,
              size: SenseiConst.iconSize.sp,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            widget.title,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.h),
          Text(
            _currentValue.toString(),
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
