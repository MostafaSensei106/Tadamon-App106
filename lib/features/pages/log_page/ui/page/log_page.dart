import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadamon/features/pages/log_page/logic/logs_bloc.dart';
import 'package:tadamon/features/pages/log_page/logic/logs_event.dart';
import 'package:tadamon/features/pages/log_page/ui/widgets/logs_page_view.dart';

class LogsPage extends StatelessWidget {
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogsBloc()..add(LoadLogs()),
      child: const LogsPageView(),
    );
  }
}


