import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadamon/features/pages/search_page/logic/search_cubit.dart';
import 'package:tadamon/features/pages/search_page/ui/widget/search_page_view.dart';
import 'package:tadamon/features/products_scanner/data/repository/fire_store_services.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(FireStoreServices()),
      child: SearchPageView(),
      
    );
  }
}
