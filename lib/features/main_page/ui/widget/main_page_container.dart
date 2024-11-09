import 'package:flutter/material.dart';

class MainPageContainer extends StatelessWidget {
  final PageController pageController;
  final ValueChanged<int> onPageChanged;

  const MainPageContainer({
    super.key,
    required this.pageController,
    required this.onPageChanged,
  });

  @override
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
        Container(),
        Container(),
        Container(),
      ],
    );
  }
}
