import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tadamon/features/pages/log_page/logic/logs_bloc.dart';
import 'package:tadamon/features/pages/log_page/logic/logs_event.dart';
import 'package:tadamon/features/pages/log_page/logic/logs_state.dart';

class LogsPage extends StatelessWidget {
  const LogsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LogsBloc()..add(LoadLogs()),
      child: const LogsView(),
    );
  }
}

class LogsView extends StatelessWidget {
  const LogsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (query) =>
                context.read<LogsBloc>().add(SearchLogs(query)),
            decoration: InputDecoration(
              labelText: 'Search Logs',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<LogsBloc, LogsState>(
            builder: (context, state) {
              if (state is LogsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is LogsLoaded) {
                return ListView.builder(
                  itemCount: state.logs.length,
                  itemBuilder: (context, index) {
                    final log = state.logs[index];
                    return ListTile(
                      title: Text(log.productName),
                      subtitle: Text(log.serialNumber),
                    );
                  },
                );
              } else {
                return const Center(child: Text('No Logs Available'));
              }
            },
          ),
        ),
      ],
    );
  }
}