import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadamon/features/pages/main_page/ui/widget/app_bar/app_bar.dart';
import 'package:tadamon/core/widget/app_drawer/drawer.dart';
import 'package:tadamon/features/pages/main_page/ui/widget/google_nav_bar/google_nav_bar.dart';
import 'package:tadamon/features/pages/main_page/logic/main_page_cubit.dart';
import 'package:tadamon/features/pages/main_page/logic/main_page_state.dart';
import 'package:tadamon/features/pages/main_page/ui/widget/main_page_container.dart';
import 'package:tadamon/generated/l10n.dart';

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
  /// Initializes the state of the widget.
  ///
  /// This is called when the widget is inserted into the tree.
  ///
  /// It initializes the page controller and the page cubit.
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageCubit = PageCubit();
  }

  @override
  /// Disposes of the page controller and the page cubit.
  ///
  /// This is called when the widget is removed from the tree.
  ///
  /// It is important to call [dispose] to free up resources when the widget
  /// is no longer needed.
  void dispose() {
    _pageController.dispose();
    _pageCubit.close();
    super.dispose();
  }

/// Handles the page change event for the `PageView`.
///
/// This method is triggered when a new page is selected in the `PageView`.
/// It updates the current page in the `PageCubit` using the given [index].
///
/// The [index] parameter is the index of the page that the user navigated to.

/// Updates the current page in the `PageCubit` when a new page is selected.
///
/// This method is called whenever the user navigates to a different page
/// in the `PageView`. It takes the [index] of the new page and updates
/// the `PageCubit` state to reflect the currently selected page.
///
/// The [index] parameter corresponds to the index of the page that
/// the user has navigated to in the `PageView`.

  void _onPageChanged(int index) {
    _pageCubit.changePage(AppPage.values[index]);
  }

  /// Handles the tap event for the `GoogleNavBar` items.
  ///
  /// This method is triggered when an item is tapped in the `GoogleNavBar`.
  /// It animates the page to the selected index using the `PageController`.
  ///
  /// The [index] parameter is the index of the page that the user navigated to.
  void onItemTapped(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

/// Returns the title for the app bar based on the given [page].
///
/// The title is determined by the current page index of the `PageCubit` state.
/// It returns localized strings for "Home", "Search", and "Logs" based on the index.
/// If the index does not match any known page, it returns "Unknown Page".
///
/// The [page] parameter represents the current page in the application.

  String _getAppBarTitle(AppPage page) {
    switch (_pageCubit.state.currentPage.index) {
      case 0:
        return S.of(context).Home;
      case 1:
        return S.of(context).Search;
      case 2:
        return S.of(context).Logs;
      default:
        return 'Unknown Page';
    }
  }

  @override
  /// Builds the main page of the application.
  ///
  /// This is the top most widget of the application. It is a [Scaffold] with
  /// a [SenseiAppBar] in the app bar, a [SenseiDrawer] as the drawer, and
  /// a [Stack] as the body.
  ///
  /// The [Stack] contains two children: a [MainPageContainer] and a
  /// [GoogleNavBar] positioned at the bottom of the screen.
  ///
  /// The [MainPageContainer] is a [PageView] that displays the different
  /// pages of the application. The [GoogleNavBar] is a navigation bar
  /// that allows the user to navigate between the different pages.
  ///
  /// The [GoogleNavBar] is configured with the current page index of the
  /// [PageCubit] state, and the [onItemTapped] callback is set to the
  /// [_onItemTapped] method which is used to navigate between the pages.
  ///
  /// The [_getAppBarTitle] method is used to get the title of the app bar
  /// based on the current page index of the [PageCubit] state.
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider.value(
      value: _pageCubit,
      child: BlocBuilder<PageCubit, MainPageState>(
        builder: (context, state) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            key: const ValueKey<String>('main_page_scaffold'),
            backgroundColor: Theme.of(context).colorScheme.surface,
            appBar: SenseiAppBar(
              _getAppBarTitle(state.currentPage),
            ),
            drawer: SenseiDrawer(),
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
