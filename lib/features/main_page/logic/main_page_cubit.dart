import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadamon_app/features/main_page/logic/main_page_state.dart';

class PageCubit extends Cubit<MainPageState> {
  PageCubit() : super(const MainPageState());

  void changePage(AppPage page) {
    emit(state.copyWith(currentPage: page));
  }
}
