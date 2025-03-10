import 'package:flutter/material.dart';
import 'package:tadamon/core/config/theme/colors/logic/theme_helper/theme_helper.dart';

class NoRoutes extends StatelessWidget {
  const NoRoutes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الصفحة غير موجودة'),
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
                color: appThemeData.colorScheme.error,
                size: 100,
              ),
              const SizedBox(height: 20),
              Text(
                'لم يتم العثور على الصفحة:',
                style: appThemeData.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: appThemeData.colorScheme.error,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                '${ModalRoute.of(context)?.settings.name}',
                style: appThemeData.textTheme.bodyLarge?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey[600],
                    ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: appThemeData.colorScheme.error,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'العودة إلى الصفحة الرئيسية',
                  style: TextStyle(
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
