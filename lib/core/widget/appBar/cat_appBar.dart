import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadamon_app/core/logic/locals_cubit.dart';

class CatAppBar extends StatelessWidget {
  final String title;

  const CatAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final locale = context.watch<LanguageCubit>().state.locale;
    final isLTR = locale?.languageCode == 'en' || locale?.languageCode == 'ja';

    return AppBar(
      elevation: 0,
      titleSpacing: 0,
      automaticallyImplyLeading: false,
      actions: [
        IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: const Icon(Icons.more_vert),
          alignment: isLTR ? Alignment.centerLeft : Alignment.centerRight,
        ),
      ],
      title: Padding(
        padding: isLTR
            ? const EdgeInsets.only(left: 10.0)
            : const EdgeInsets.only(right: 10.0),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation),
              child: FadeTransition(
                opacity: animation,
                child: child,
              ),
            );
          },
          child: Text(
            title,
            key: ValueKey<String>(title),
            textAlign: isLTR ? TextAlign.center : TextAlign.right,
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
        ),
      ),
    );
  }
}
