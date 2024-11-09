import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadamon_app/core/widget/google_nav_bar/google_nav_bar.dart';
import 'package:tadamon_app/features/main_page/logic/main_page_cubit.dart';
import 'package:tadamon_app/features/main_page/logic/main_page_state.dart';
import 'package:tadamon_app/features/main_page/ui/widget/main_page_container.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    context.read<PageCubit>().changePage(AppPage.values[index]);
  }

  void onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PageCubit(),
      child: BlocBuilder<PageCubit, MainPageState>(builder: (context, state) {
        return Scaffold(
          key: const ValueKey<String>('main_page_scaffold'),
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            title: Text('تضامن'),
          ),
          drawer: Drawer(),
          body: Stack(
            children: [
              MainPageContainer(
                pageController: _pageController,
                onPageChanged: _onPageChanged,
              ),
              Positioned(
                bottom: 0,
                left: 60,
                right: 60,
                child: GoogleNavBar(
                  onItemTapped: onItemTapped,
                  currentIndex: state.currentPage.index,
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  // String _getAppBarTitle(AppPage page) {
  //   switch (page) {
  //     case AppPage.home:
  //       return 'Home';
  //     case AppPage.search:
  //       return 'search';
  //     case AppPage.Logs:
  //       return 'Logs';
  //   }
  // }
}
