import 'dart:convert';
import 'dart:async';

import 'package:flutter_app_dynamic/framework/flutter_dynamic.dart';

class FrameworkEventOwner {
  static void invoke(event) async {
    await FlutterDynamic.jsFlutterMainChannel.invokeMethod('callJsEvent', {
      "event": event
    });
  }
}

class FrameworkBuildOwner {
  static StreamController _streamController = StreamController();
  static StreamController getStreamController() {
    return _streamController;
  }
  static dynamic createNode(String json) {
    return jsonDecode(json);
  }
  static void rebuild(String json) {
    _streamController.add(createNode(json));
  }
  static void close() {
    _streamController.close();
  }
}