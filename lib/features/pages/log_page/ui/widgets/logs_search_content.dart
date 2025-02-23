import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widget/lottie_component/lottie_component.dart';
import 'package:tadamon/features/pages/log_page/logic/logs_bloc.dart';
import 'package:tadamon/features/pages/log_page/logic/logs_state.dart';
import 'package:tadamon/features/pages/log_page/ui/widgets/ss.dart';

class LogsSearchContent extends StatelessWidget {
  const LogsSearchContent({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<LogsBloc, LogsState>(
        builder: (context, state) {
          if (state is LogsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LogsLoadingSuccess) {
            if (state.products.isEmpty) {
              return _searchController.text.isEmpty
                  ? LottieComponent(
                      lottiePath: SenseiConst.lottieSearchAnimation,
                      text: 'نتائج البحث سوف تظهر هنا')
                  : LottieComponent(
                      lottiePath: SenseiConst.lottieNoFoundAnimation,
                      text: 'لم يتم العثور على المنتج في السجلات');
            }
            return ListView.separated(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return ProductLogsExpansionTileComponent(product: product);
              },
              separatorBuilder: (context, index) =>
                  SizedBox(height: SenseiConst.margin.h),
            );
          } else if (state is LogsError) {
            return Center(
             child: Text('Error: ${state.message}'),
            );
          } else {
            return Center(
                child: LottieComponent(
                    lottiePath: SenseiConst.lottieSearchAnimation,
                    text: 'نتائج البحث سوف تظهر هنا'));
          }
        },
      ),
    );
  }
}
