import 'package:flutter/material.dart';
import 'package:flutter_app_dynamic/framework/framework.dart';

void main() {
  FlutterDynamic.setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FlutterDynamic.build(),
    );
  }
}
