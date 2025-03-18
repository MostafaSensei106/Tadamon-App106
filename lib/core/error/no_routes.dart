import 'package:flutter/material.dart';

class NoRoutes extends StatelessWidget {
  const NoRoutes({super.key});

  @override
  /// Returns a [Scaffold] widget with an [AppBar] containing a title and a
  /// centered [Text] widget, and a [Center] widget containing a [Padding]
  /// widget with a [Column] widget as child, which is configured with a
  /// [mainAxisAlignment] of [MainAxisAlignment.center].
  ///
  /// The [Column] widget has three children: an [Icon] widget, a [SizedBox]
  /// widget, and a [Text] widget.
  ///
  /// The [Icon] widget is configured with an [Icons.warning_amber_rounded]
  /// icon, a size of 100, and a color of
  /// [Theme.of(context).colorScheme.error].
  ///
  /// The [Text] widget is configured with a text of 'لم يتم العثور على
  /// الصفحة:', a style of a [TextStyle] with a [fontWeight] of
  /// [FontWeight.bold], and a color of [Theme.of(context).colorScheme.error].
  ///
  /// The [Text] widget is followed by a [SizedBox] widget with a height of 20.
  ///
  /// The [Text] widget is then followed by a [Text] widget with a text of
  /// '${ModalRoute.of(context)?.settings.name}', a style of a [TextStyle]
  /// with a [fontStyle] of [FontStyle.italic], and a color of [Colors.grey[600]].
  ///
  /// The [Text] widget is then followed by a [SizedBox] widget with a height of 30.
  ///
  /// The [Text] widget is then followed by an [ElevatedButton] widget with an
  /// onPressed callback that calls [Navigator.pop(context)], a style of
  /// [ElevatedButton.styleFrom] with a [backgroundColor] of
  /// [Theme.of(context).colorScheme.error], a [padding] of
  /// const EdgeInsets.symmetric(horizontal: 24, vertical: 12), and a [shape]
  /// of [RoundedRectangleBorder] with a [borderRadius] of
  /// BorderRadius.circular(8), and a child of a [Text] widget with a text of
  /// 'العودة إلى الصفحة الرئيسية', a style of a [TextStyle] with a [fontSize]
  /// of 16, a [fontWeight] of [FontWeight.bold], and a color of
  /// [Colors.black].
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
                color: Theme.of(context).colorScheme.error,
                size: 100,
              ),
              const SizedBox(height: 20),
              Text(
                'لم يتم العثور على الصفحة:',
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
