import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadamon_app/core/widget/appBar/app_bar.dart';
import 'package:tadamon_app/core/widget/appBar/app_bar_title.dart';
import 'package:tadamon_app/core/widget/google_nav_bar/google_nav_bar.dart';
import 'package:tadamon_app/features/main_page/logic/main_page_cubit.dart';
import 'package:tadamon_app/features/main_page/logic/main_page_state.dart';
import 'package:tadamon_app/features/main_page/ui/widget/main_page_container.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin {
  late final PageController _pageController;
  late final PageCubit _pageCubit;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageCubit = PageCubit();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _pageCubit.close();
    super.dispose();
  }

  void _onPageChanged(int index) {
    _pageCubit.changePage(AppPage.values[index]);
  }

  void onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  //App Bar Title Will Change Depending on Page
  String getTitle() {
    switch (_pageCubit.state.currentPage) {
      case AppPage.home:
        return 'Home';
      case AppPage.search:
        return 'Search';
      case AppPage.logs:
        return 'Logs';
      default:
        return 'Unknown Page';
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider.value(
      value: _pageCubit,
      child: BlocBuilder<PageCubit, MainPageState>(
        builder: (context, state) {
          return Scaffold(
            key: const ValueKey<String>('main_page_scaffold'),
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: SenseiAppBar(
              title: AppBarTitle(title: getTitle()),
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
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
