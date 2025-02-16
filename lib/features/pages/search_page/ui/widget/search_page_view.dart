import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widget/text_filed_component/text_filed_component.dart';
import 'package:tadamon/features/pages/search_page/logic/search_bloc.dart';
import 'package:tadamon/features/pages/search_page/logic/search_event.dart';
import 'package:tadamon/features/pages/search_page/logic/search_state.dart';
import 'package:tadamon/features/pages/search_page/ui/widget/product_expansion_tile.dart';

class SearchPageView extends StatefulWidget {
  const SearchPageView({super.key});

  @override
  State<SearchPageView> createState() => _SearchPageViewState();
}

class _SearchPageViewState extends State<SearchPageView> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'Name';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(SenseiConst.padding),
      child: Column(
        children: [
          searchRow(context),
          SizedBox(height: SenseiConst.margin.h),
          ResultContent(searchController: _searchController),
        ],
      ),
    );
  }

  Row searchRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFieldComponent(
              useOutBorderRadius: true,
              controller: _searchController,
              icon: Icons.search,
              suffixIcon: PopupMenuButton(itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 'Name',
                    child: Text('Name'),
                  ),
                  PopupMenuItem(
                    value: 'Category',
                    child: Text('Category'),
                  ),
                  PopupMenuItem(
                    value: 'Price',
                    child: Text('Price'),
                  ),
                ];
              }),
              hint: 'ابحث عن منتج',

              onChange: (value) => context.read<SearchBloc>().add(
                    FetchSearchResult(value, _selectedFilter),
                  )),
        ),
        SizedBox(width: 8.w),
        DropdownButton<String>(
          value: _selectedFilter,
          onChanged: (String? newValue) {
            setState(() {
              _selectedFilter = newValue!;
            });
          },
          items: <String>['Name', 'Category', 'Price']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ],
    );
  }
}

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
