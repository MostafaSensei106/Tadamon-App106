import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widget/search_bar_component/search_bar.dart';
import 'package:tadamon/features/pages/help_user_page/page/help_user_page.dart';
import 'package:tadamon/features/pages/search_page/logic/search_cubit.dart';
import 'package:tadamon/features/pages/search_page/logic/search_state.dart';
import 'package:tadamon/features/products_scanner/ui/widget/product_list_tile.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SenseiConst.padding.w,
      ),
      child: Column(
        children: [
          SenseiSearchBar(
            onSearchChanged: (query) {
              context.read<SearchCubit>().searchOnFireStore(query);
            },
          ),
          BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              if (state is SearchStateLoadingSuccess) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      return ProductExpansionTile(
                          product: state.products[index]);
                    },
                  ),
                );
              } else if (state is SearchStateLoadingError) {
                return Center(child: Text(state.errorMessage));
              } else if (state is SearchStateLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return Text('No products found');
            },
          ),
        ],
      ),
    );
  }
}
