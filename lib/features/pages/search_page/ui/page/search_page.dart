import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadamon/features/pages/search_page/logic/search_bloc.dart';
import 'package:tadamon/features/pages/search_page/ui/widget/search_page_view.dart';
import 'package:tadamon/features/products_scanner/data/repository/fire_store_repositories.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchBloc(FireStoreRepositorie()),
      child: const SearchPageView(),
    );
  }
}
