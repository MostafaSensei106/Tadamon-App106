import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) {
          return ListTile(
            leading: FlutterLogo(
              size: 50,
            ),
            title: Text('Item $index'),
            subtitle: Text('Item $index'),
            trailing: Icon(Icons.arrow_forward_ios_sharp),
          );
        },
      ),
    );
  }
}
