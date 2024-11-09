enum AppPage { image, video, saved }

class MainPageState {
  final AppPage currentPage;

  const MainPageState({this.currentPage = AppPage.image});

  MainPageState copyWith({AppPage? currentPage}) {
    return MainPageState(
      currentPage: currentPage ?? this.currentPage,
    );
  }
}
