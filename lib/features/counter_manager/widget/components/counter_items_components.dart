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
