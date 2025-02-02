import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadamon/features/pages/home_page/ui/page/home_page.dart';
import 'package:tadamon/features/pages/log_page/ui/page/log_page.dart';
import 'package:tadamon/features/pages/search_page/logic/search_cubit.dart';
import 'package:tadamon/features/pages/search_page/ui/page/search_page.dart';

class MainPageContainer extends StatelessWidget {
  final PageController pageController;
  final ValueChanged<int> onPageChanged;

  const MainPageContainer({
    super.key,
    required this.pageController,
    required this.onPageChanged,
  });

  @override

  /// A PageView widget that displays the three main pages of the app: Home, Search, and Logs.
  /// The controller is used to manage the page state, and the onPageChanged callback is used
  /// to notify the parent widget when the page changes.
  /// When the page changes, the focus is removed from any TextField that may have been active.
  /// This prevents the keyboard from showing when the user navigates away from a page that contains
  /// a TextField.
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        if (index == 1 || index == 0 || index == 2) {
          FocusScope.of(context).unfocus();
        }
        onPageChanged(index);
      },
      children: [
        HomePage(),
        BlocProvider(
          create: (context) => SearchCubit(),
          child: SearchPage(),
        ),
        LogsPage(),
      ],
    );
  }
}
