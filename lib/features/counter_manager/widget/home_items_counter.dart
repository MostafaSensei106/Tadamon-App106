import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widgets/counter_items_component/counter_items_component.dart';
import 'package:tadamon/features/counter_manager/logic/counter_manager.dart';
import 'package:tadamon/generated/l10n.dart';

class ItemsCounter extends StatefulWidget {
  const ItemsCounter({super.key});

  @override
  State<ItemsCounter> createState() => _ItemsCounterState();
}

class _ItemsCounterState extends State<ItemsCounter> {
  late StreamSubscription<int> _scannedProductsSubscription;
  late StreamSubscription<int> _supportedProductsSubscription;

  int _scannedProducts = 0;
  int _supportedProducts = 0;

  @override
  void initState() {
    super.initState();

    // Subscribe to scanned products stream
    _scannedProductsSubscription =
        CounterManager.scannedProductsStream.listen((count) {
      setState(() {
        _scannedProducts = count;
      });
    });

    // Subscribe to supported products stream
    _supportedProductsSubscription =
        CounterManager.supportedProductsStream.listen((count) {
      setState(() {
        _supportedProducts = count;
      });
    });

    // Initialize counters
    CounterManager.initializeScannedProducts();
    CounterManager.initializeSupportedProducts();
  }

  @override
  void dispose() {
    _scannedProductsSubscription.cancel();
    _supportedProductsSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: SenseiConst.margin.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: CounterItemsComponent(
              icon: Icons.qr_code_rounded,
              title: S.of(context).scanBarcode,
              counter: _scannedProducts,
            ),
          ),
          SizedBox(width: SenseiConst.margin.w),
          Expanded(
            child: CounterItemsComponent(
              icon: Icons.checklist_rounded,
              title: S.of(context).supportedProducts,
              counter: _supportedProducts,
            ),
          )
        ],
      ),
    );
  }
}