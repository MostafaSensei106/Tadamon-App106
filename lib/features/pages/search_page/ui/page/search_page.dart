import 'package:flutter/material.dart';
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
        padding:  EdgeInsets.all(SenseiConst.padding),
        child: Column(
          children: [
            SearchAnchor.bar(
              barElevation:WidgetStateProperty.all(0),
              barBackgroundColor:WidgetStateProperty.all(Theme.of(context).colorScheme.surfaceContainer),
              
              suggestionsBuilder: (context, query) => const []
              ),
          ],
        ));
  }
}
