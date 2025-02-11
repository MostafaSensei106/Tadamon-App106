import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_maps/maps.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/generated/l10n.dart';

// class PalestineMapPage extends StatelessWidget {
//   const PalestineMapPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(S.of(context).PalatineMap),
//         centerTitle: true,
//       ),
//       body: InteractiveViewer(
//         child: Image.asset(
//           SenseiConst.palestineMap,
//           width: double.infinity,
//           height: double.infinity,
//           fit: BoxFit.cover,
//           filterQuality: FilterQuality.low,
//           frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
//             if (frame == null) {
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//             return child;
//           },
//           errorBuilder: (context, error, stackTrace) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const Icon(
//                     Icons.error_outline,
//                     color: Colors.red,
//                     size: SenseiConst.iconSize,
//                   ),
//                   const SizedBox(height: 16),
//                   Text(
//                     'حدث خطأ في تحميل الصورة',
//                     style: Theme.of(context).textTheme.bodyLarge,
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

class PalestineMapPage extends StatefulWidget {
  const PalestineMapPage({super.key});

  @override
  State<PalestineMapPage> createState() => _PalestineMapPageState();
}

class _PalestineMapPageState extends State<PalestineMapPage> {
  late MapShapeSource _mapSource;
  bool isLoading = true;

  @override
  @override
  void initState() {
    super.initState();
    _loadMapData();
  }

  Future<void> _loadMapData() async {
    _mapSource = MapShapeSource.asset(
      'assets/palestine.json',
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).PalatineMap),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.double_arrow_rounded),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(SenseiConst.padding.w),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(SenseiConst.outBorderRadius.r),
        ),
        child: InteractiveViewer(
          child:isLoading ? const Center(child: CircularProgressIndicator()) : SfMaps(
            layers: <MapShapeLayer>[
              MapShapeLayer(
                source: _mapSource,
                strokeWidth: 0.5,
                strokeColor: Theme.of(context).colorScheme.onSecondaryContainer,
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
