import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widget/text_filed_component/text_filed_component.dart';
import 'package:tadamon/features/pages/log_page/logic/bloc/logs_bloc.dart';
import 'package:tadamon/features/pages/log_page/logic/bloc/logs_event.dart';
import 'package:tadamon/features/pages/log_page/ui/widgets/logs_search_content.dart';

class LogsPageView extends StatefulWidget {
  const LogsPageView({super.key});

  @override
  State<LogsPageView> createState() => _LogsPageViewState();
}

class _LogsPageViewState extends State<LogsPageView> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedFilter = 'SerialNumber';



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(SenseiConst.padding),
      child: Column(
        children: [
          searchBar(context),
          SizedBox(height: SenseiConst.margin.h),
          LogsSearchContent(searchController: _searchController),
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
              borderRadius: BorderRadius.circular(SenseiConst.inBorderRadius.r),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(SenseiConst.inBorderRadius.r),
                side: BorderSide(
                  color: Theme.of(context).colorScheme.outline.withAlpha(0x80),
                ),
              ),
              padding: EdgeInsets.zero,
              tooltip: 'فلتر البحث',
              color: Theme.of(context).colorScheme.surface,
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 'SerialNumber',
                    child: Row(
                      children: [
                        const Icon(
                          Icons.qr_code_rounded,
                          size: SenseiConst.iconSize,
                        ),
                        SizedBox(width: SenseiConst.padding.w),
                        const Text('الرقم التسلسلي'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                      value: 'Name',
                      child: Row(
                        children: [
                          const Icon(
                            Icons.label_outline_rounded,
                            size: SenseiConst.iconSize,
                          ),
                          SizedBox(width: SenseiConst.padding.w),
                          const Text('اسم المنتج'),
                        ],
                      )),
                  PopupMenuItem(
                    value: 'Manufacture',
                    child: Row(
                      children: [
                        const Icon(
                          Icons.business,
                          size: SenseiConst.iconSize,
                        ),
                        SizedBox(width: SenseiConst.padding.w),
                        const Text('المُصنع'),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    value: 'Category',
                    child: Row(
                      children: [
                        const Icon(
                          Icons.category_outlined,
                          size: SenseiConst.iconSize,
                        ),
                        SizedBox(width: SenseiConst.padding.w),
                        const Text('القسم'),
                      ],
                    ),
                  ),
                ];
              },
            ),
            hint:
                'ابحث عن ${_selectedFilter == 'Name' ? 'اسم المنتج' : _selectedFilter == 'SerialNumber' ? 'الرقم التسلسلي' : _selectedFilter == 'Manufacture' ? 'المُصنع' : 'القسم'}...',
            onChange: (value) {
              BlocProvider.of<LogsBloc>(context)
                  .add(GetLogsResult(value, _selectedFilter));
            },
          ),
        ),
      ],
    );
  }
}
