import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widget/text_filed_component/text_filed_component.dart';
import 'package:tadamon/features/pages/search_page/logic/search_bloc.dart';
import 'package:tadamon/features/pages/search_page/logic/search_event.dart';
import 'package:tadamon/features/pages/search_page/ui/widget/result_content.dart';

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
          searchBar(context),
          SizedBox(height: SenseiConst.margin.h),
          ResultContent(searchController: _searchController),
        ],
      ),
    );
  }

  Row searchBar(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFieldComponent(
              useOutBorderRadius: true,
              controller: _searchController,
              icon: Icons.search,
              suffixIcon: PopupMenuButton<String>(
                onSelected: (value) {
                  setState(() {
                    _selectedFilter = value;
                  });
                },
                icon: const Icon(
                  Icons.filter_list,
                  size: SenseiConst.iconSize,
                ),
                elevation: 0,
                enableFeedback: true,
                borderRadius:
                    BorderRadius.circular(SenseiConst.inBorderRadius.r),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(SenseiConst.inBorderRadius.r),
                  side: BorderSide(
                    width: 0.2,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                padding: EdgeInsets.zero,
                tooltip: 'فلتر البحث',
                color: Theme.of(context).colorScheme.surface,
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 'Name',
                      child:  ListTile(
                        leading: Icon(
                          Icons.label_outline_rounded,
                          size: SenseiConst.iconSize,
                        ),
                        title: Text('اسم المنتج'),
                      )
                    ),
                    PopupMenuItem(
                      value: 'SerialNumber',
                      child: Row(
                        children: [
                          Icon(
                            Icons.numbers,
                            size: SenseiConst.iconSize,
                          ),
                          SizedBox(width: SenseiConst.padding.w),
                          Text('الرقم التسلسلي'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'Manufacture',
                      child: Row(
                        children: [
                          Icon(
                            Icons.business,
                            size: SenseiConst.iconSize,
                          ),
                          SizedBox(width: SenseiConst.padding.w),
                          Text('المُصنع'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'Category',
                      child: Row(
                        children: [
                          Icon(
                            Icons.category_outlined,
                            size: SenseiConst.iconSize,
                          ),
                          SizedBox(width: SenseiConst.padding.w),
                          Text('القسم'),
                        ],
                      ),

                    ),
                  ];
                },
              ),
              hint:
                  'ابحث عن ${_selectedFilter == 'Name' ? 'اسم المنتج' : _selectedFilter == 'SerialNumber' ? 'الرقم التسلسلي' : _selectedFilter == 'Manufacture' ? 'المُصنع' : 'القسم'}...',
              onChange: (value) => context.read<SearchBloc>().add(
                    FetchSearchResult(value, _selectedFilter),
                  )),

                  
        ),
      ],
    );
  }

  Widget filter_list (BuildContext context , String title , IconData icon, String value){ {
    return PopupMenuItem(
      value: value,
      child:  ListTile(
        leading: Icon(
          icon,
          size: SenseiConst.iconSize,
        ),
        title: Text(title),
      )
    );
  }
}
}