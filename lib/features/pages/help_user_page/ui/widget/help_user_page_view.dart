import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widget/expansion_tile_component/expansion_tile_component.dart';
import 'package:tadamon/features/pages/help_user_page/logic/cubit/help_user_cubit.dart';
import 'package:tadamon/features/pages/help_user_page/logic/cubit/help_user_state.dart';
import 'package:tadamon/features/pages/help_user_page/logic/help_search_delegate.dart';
import 'package:tadamon/generated/l10n.dart';

class HelpUserPageView extends StatelessWidget {
  const HelpUserPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).HowToUse),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              final state = context.read<HelpUserCubit>().state;
              if (state is HlepUserLoadingQnaStateSuccess) {
                showSearch(
                  context: context,
                  delegate: HelpSearchDelegate(
                    qnaList: state.qnaList,
                    onSearch: context.read<HelpUserCubit>().searchQA,
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<HelpUserCubit, HelpUserState>(
          builder: (context, state) {
            if (state is HlepUserLoadingQnaState) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is HelpUserErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(state.error),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<HelpUserCubit>().loadQna(),
                      child: const Text('إعادة المحاولة'),
                    ),
                  ],
                ),
              );
            }

            if (state is HlepUserLoadingQnaStateSuccess) {
              return ListView.separated(
                itemCount: state.qnaList.length,
                padding: EdgeInsets.all(SenseiConst.padding.w),
                itemBuilder: (context, index) {
                  final qna = state.qnaList[index];
                  return ExpansionTileComponent(
                    leadingIcon: Icons.help_outline,
                    title: qna.question,
                    subtitle: qna.simAnswer,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          qna.fullAnswer,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 8.0),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
