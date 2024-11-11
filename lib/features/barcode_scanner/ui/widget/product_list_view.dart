import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tadamon/core/config/const/sensei_const.dart';
import 'package:tadamon/core/widget/divider.dart';

class ProductListView extends StatelessWidget {
  final String resSerialNumber;

  const ProductListView({super.key, required this.resSerialNumber});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => ListTile(
            leading: Icon(
              Icons.list,
              size: SenseiConst.iconSize,
            ),
            title: const Text('الرقم التسلسلي'),
            subtitle: Text(resSerialNumber),
            trailing: IconButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: resSerialNumber));
                },
                icon: const Icon(Icons.copy)),
          ),
          separatorBuilder: (context, index) => const SenseiDivider(),
          itemCount: 1,
        ),
      ],
    );
  }
}
