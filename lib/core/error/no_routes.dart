import 'package:flutter/material.dart';
import 'package:tadamon/generated/l10n.dart';

class NoRoutes extends StatelessWidget {
  const NoRoutes({super.key});

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(
          S.of(context).noPage
          ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                color: Theme.of(context).colorScheme.error,
                size: 100,
              ),
              const SizedBox(height: 20),
              Text(
                S.of(context).noRoutes,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.error,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                '${ModalRoute.of(context)?.settings.name}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child:  Text(
                  S.of(context).back,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                      ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
