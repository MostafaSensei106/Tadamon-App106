import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

class CounterItemsComponent extends StatelessWidget {
  final IconData icon;
  final String title;
  final Future<int> Function() getCounter;
  final Stream<int> counterStream;

  const CounterItemsComponent({
    super.key,
    required this.icon,
    required this.title,
    required this.getCounter,
    required this.counterStream,
  });

  @override
  /// A widget that displays a [Container] with a rounded border and a
  /// [Column] inside it. The [Column] contains a [Container] with a
  /// rounded border and an [Icon] inside it, a [Text] widget with the
  /// given [title], and a [FutureBuilder] widget that displays a
  /// [CircularProgressIndicator] until the [getCounter] function is
  /// complete. Once the [getCounter] function is complete, the
  /// [FutureBuilder] widget displays the result of the [getCounter]
  /// function as a [Text] widget. If the [getCounter] function fails,
  /// the [FutureBuilder] widget displays an error message as a [Text]
  /// widget. If the [counterStream] is not null, the [FutureBuilder]
  /// widget also displays the result of the [counterStream] as a
  /// [Text] widget, with a tween animation that animates the value
  /// from 0 to the result of the [counterStream] over a period of 1
  /// second.
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
              icon,
              size: SenseiConst.iconSize.sp,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            title,
          ),
          SizedBox(
            height: 4.h,
          ),
          FutureBuilder(
              future: getCounter(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data.toString(),
                  );
                }
                if (snapshot.hasError) {
                  return Text(
                    "Error: ${snapshot.error}",
                  );
                }
                return StreamBuilder<int>(
                  stream: counterStream,
                  initialData: 0,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text(
                        '0',
                      );
                    }
                    return TweenAnimationBuilder(
                      tween: IntTween(begin: 0, end: snapshot.data!),
                      duration: const Duration(seconds: 1),
                      builder: (context, int value, child) {
                        return Text(
                          value.toString(),
                        );
                      },
                    );
                  },
                );
              })
        ],
      ),
    );
  }
}
