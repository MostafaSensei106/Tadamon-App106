
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/features/pages/search_page/logic/search_bloc.dart';
import 'package:tadamon/features/pages/search_page/logic/search_state.dart';
import 'package:tadamon/features/pages/search_page/ui/widget/product_expansion_tile.dart';

class ResultContent extends StatelessWidget {
  const ResultContent({
    super.key,
    required TextEditingController searchController,
  }) : _searchController = searchController;

  final TextEditingController _searchController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SearchLoadingSuccess) {
            if (state.products.isEmpty) {
              return Center(
                child: Text(
                  _searchController.text.isEmpty
                      ? 'نتائج البحث سوف تظهر هنا'
                      : 'المنتج غير موجود',
                ),
              );
            }
            return ListView.separated(
              itemCount: state.products.length,
              itemBuilder: (context, index) {
                final product = state.products[index];
                return ProductExpansionTile(product: product);
              },
              separatorBuilder: (context, index) =>
                  SizedBox(height: SenseiConst.margin.h),
            );
          } else if (state is SearchError) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          } else {
            return Center(
              child: Text(
                'نتائج البحث سوف تظهر هنا',
              ),
            );
          }
        },
      ),
    );
  }
}
