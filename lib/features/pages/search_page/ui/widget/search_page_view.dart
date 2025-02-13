import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/features/pages/search_page/logic/search_cubit.dart';

class SearchPageView extends StatefulWidget {
  const SearchPageView({super.key});

  @override
  State<SearchPageView> createState() => _SearchPageViewState();
}

class _SearchPageViewState extends State<SearchPageView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(SenseiConst.padding),
        child: Column(
          children: [
            TextField(
              onChanged: (value) =>
                  context.read<SearchCubit>().searchProducts(value),
            ),
            Expanded(
              child: BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  if (state is SearchLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SearchError) {
                    return Center(child: Text(state.message));
                  } else if (state is SearchSuccess) {
                    return ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        return ListTile(
                          title: Text(product.productName),
                          subtitle: Text(product.serialNumber),
                          trailing: product.isTrusted
                              ? const Icon(Icons.check_circle,
                                  color: Colors.green)
                              : const Icon(Icons.cancel, color: Colors.red),
                        );
                      },
                    );
                  } else {
                    return const Center(child: Text('ابدأ البحث عن منتج'));
                  }
                },
              ),
            ),
          ],
        ));
  }
}
