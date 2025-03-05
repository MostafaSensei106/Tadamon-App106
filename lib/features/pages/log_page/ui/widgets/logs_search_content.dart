import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widget/lottie_component/lottie_component.dart';
import 'package:tadamon/features/pages/log_page/logic/logs_bloc.dart';
import 'package:tadamon/features/pages/log_page/logic/logs_state.dart';
import 'package:tadamon/features/pages/log_page/ui/widgets/productlogs_expansiontile_component.dart';

class LogsSearchContent extends StatelessWidget {
  const LogsSearchContent({
    super.key,
    required TextEditingController searchController,
  });


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
              return  const LottieComponent(
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
            return const Center(
                child: LottieComponent(
                    lottiePath: SenseiConst.lottieSearchAnimation,
                    text: 'نتائج البحث سوف تظهر هنا'));
          }
        },
      ),
    );
  }
}
