import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(SenseiConst.padding),
        child: Column(
          children: [
            SearchAnchor.bar(
                barLeading: const Icon(Icons.search),
                barHintText: 'ابحث هنا ...',
                barElevation: WidgetStateProperty.all(0),
                barBackgroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.surfaceContainer),
                barShape: WidgetStatePropertyAll(RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(SenseiConst.outBorderRadius.r))),
                // barSide:WidgetStatePropertyAll(BorderSide(color: Theme.of(context).colorScheme.primary,width: 0.2)),
                barPadding:
                    WidgetStatePropertyAll(EdgeInsets.all(SenseiConst.padding)),
                viewLeading: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.all(
                        Radius.circular(SenseiConst.outBorderRadius.r)),
                    onTap: () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      Navigator.pop(context);
                    },
                    child: Container(
                        padding: EdgeInsets.all(SenseiConst.padding),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                SenseiConst.outBorderRadius.r),
                            color:
                                Theme.of(context).colorScheme.surfaceContainer),
                        child: const Icon(Icons.double_arrow_rounded)),
                  ),
                ),
                // viewBackgroundColor: Theme.of(context).colorScheme.surfaceContainer,
                viewElevation: 0,
                viewShape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(SenseiConst.outBorderRadius.r)),
                viewSide: BorderSide(
                    width: 0.2, color: Theme.of(context).colorScheme.primary),
                dividerColor: Theme.of(context).colorScheme.outline,
                isFullScreen: false,
                suggestionsBuilder: (context, onSuggestionTap) => [
                  ListView.separated(
                      itemBuilder: (context, index) => ExpansionTile(
                            title: Text('test $index'),
                          ),
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: 10)
                ]),
          ],
        ));
  }
}
