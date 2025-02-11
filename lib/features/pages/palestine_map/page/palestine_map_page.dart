import 'package:flutter/material.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/generated/l10n.dart';

class PalestineMapPage extends StatelessWidget {
  const PalestineMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).PalatineMap),
        centerTitle: true,
      ),
      body: InteractiveViewer(
        child: Image.asset(
          SenseiConst.palestineMap,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          filterQuality: FilterQuality.low,
          frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
            if (frame == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return child;
          },
          errorBuilder: (context, error, stackTrace) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: SenseiConst.iconSize,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'حدث خطأ في تحميل الصورة',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}