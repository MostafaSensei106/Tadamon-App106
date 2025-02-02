import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadamon/features/pages/search_page/logic/search_cubit.dart';

class SenseiSearchBar extends StatelessWidget {
  final Function(String) onSearchChanged;
  const SenseiSearchBar({super.key, required this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SenseiConst.padding.w,
        ),
        child: TextField(
          onChanged: (value) => onSearchChanged(value),
          onSubmitted: (value) => onSearchChanged(value),
          onEditingComplete: () => FocusScope.of(context).unfocus(),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              horizontal: SenseiConst.padding.w,
              vertical: SenseiConst.padding.h,
            ),
            filled: true,
            fillColor: Theme.of(context).colorScheme.primaryContainer,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.r),
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(Icons.search),
            hintText: 'Search for a product',
          ),
        ),
      ),
    );
  }
}
