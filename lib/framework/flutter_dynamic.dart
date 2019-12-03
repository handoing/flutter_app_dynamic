import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_app_dynamic/framework/flutter_widget.dart';
import 'package:flutter_app_dynamic/framework/framework_owner.dart';

class FlutterDynamic {

  static FlutterDynamic _instance;

  static MethodChannel jsFlutterMainChannel = MethodChannel("dynamic_main_flutter_channel");

  static setup() {
    if (_instance == null) {
      _instance = FlutterDynamic();

      bindMethodChannel();

      callJsRuntimeMain();

    }
    return _instance;
  }

  static void bindMethodChannel() {
    jsFlutterMainChannel.setMethodCallHandler((MethodCall call) async {
      switch (call.method) {
        case "receiveJsonTree":
          String resultJson = call.arguments;
          FrameworkBuildOwner.rebuild(resultJson);
          break;
        default:
          break;
      }
    });
  }

  static void callJsRuntimeMain() {
    jsFlutterMainChannel.invokeMethod("callJsRuntimeMain");
  }

  static Widget build() {
    return FlutterWidget();
  }

}