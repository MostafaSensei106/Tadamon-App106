// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:tadamon/core/config/const/sensei_const.dart';
// import 'package:tadamon/features/pages/search_page/logic/search_bloc.dart';
// import 'package:tadamon/features/pages/search_page/logic/search_state.dart';
// import 'package:tadamon/features/pages/search_page/ui/widget/product_expansion_tile.dart';

// class ResultContent extends StatelessWidget {
//   const ResultContent({
//     super.key,
//     required TextEditingController searchController,
//   }) : _searchController = searchController;

//   final TextEditingController _searchController;

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: BlocBuilder<SearchBloc, SearchState>(
//         builder: (context, state) {
//           if (state is SearchLoading) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (state is SearchLoadingSuccess) {
//             if (state.products.isEmpty) {
//               return Center(
//                 child: Text(
//                   _searchController.text.isEmpty
//                       ? 'نتائج البحث سوف تظهر هنا'
//                       : 'المنتج غير موجود',
//                 ),
//               );
//             }
//             return ListView.separated(
//               itemCount: state.products.length,
//               itemBuilder: (context, index) {
//                 final product = state.products[index];
//                 return ProductExpansionTile(product: product);
//               },
//               separatorBuilder: (context, index) =>
//                   SizedBox(height: SenseiConst.margin.h),
//             );
//           } else if (state is SearchError) {
//             return Center(
//               child: Text('Error: ${state.message}'),
//             );
//           } else {
//             return Center(
//               child: Text(
//                 'نتائج البحث سوف تظهر هنا',
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/features/pages/onboarding_page/ui/widget/animated_triangles.dart';
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
                child: _searchController.text.isEmpty
                    ? _buildSearchPlaceholder(context)
                    : _buildNotFoundPlaceholder(context),
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
              child: _buildSearchPlaceholder(context),
            );
          }
        },
      ),
    );
  }

  Widget _buildSearchPlaceholder(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(SenseiConst.padding.w),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
          ),
          child: Lottie.asset(
            'assets/animations/search_placeholder.json',
            width: 230.w,
            height: 230.h,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          'نتائج البحث سوف تظهر هنا',
          style: TextStyle(
              fontSize: 16.sp, color: Theme.of(context).colorScheme.primary),
        ),
      ],
    );
  }

  Widget _buildNotFoundPlaceholder(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            padding: EdgeInsets.all(SenseiConst.padding.w),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
          ),
          child: Lottie.asset(
            'assets/animations/not_found.json',
            width: 230.w,
            height: 230.h,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 10.h),
        Text(
          'المنتج غير موجود',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
