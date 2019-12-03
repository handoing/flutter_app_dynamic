import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_app_dynamic/framework/dynamic_builder.dart';
import 'package:flutter_app_dynamic/framework/framework_owner.dart';

class FlutterWidget extends StatefulWidget {
  FlutterWidget({Key key}) : super(key: key);

  @override
  _FlutterWidgetState createState() => _FlutterWidgetState();
}

class _FlutterWidgetState extends State<FlutterWidget> {
  StreamController _streamController;

  @override
  void initState() {
    super.initState();
    _streamController = FrameworkBuildOwner.getStreamController();
  }

  @override
  void dispose(){
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String initJsonTree = '{"widgetName":"Container"}';
    return StreamBuilder(
        stream: _streamController.stream,
        initialData: FrameworkBuildOwner.createNode(initJsonTree),
        builder: (BuildContext context, AsyncSnapshot snapshot){
          if (snapshot.hasError) return Text('Error: ${snapshot.error}');
          return DynamicWidgetBuilder.buildWidget(snapshot.data);
        }
    );
  }
}