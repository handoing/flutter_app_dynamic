package com.example.flutter_app_dynamic;

import android.os.Bundle;

import com.eclipsesource.v8.JavaVoidCallback;
import com.eclipsesource.v8.V8Array;
import com.eclipsesource.v8.V8Object;

import java.util.HashMap;
import java.util.Map;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

  public JsEngine jsEngine;

  private static final String MAIN_FLUTTER_CHANNEL_NAME = "dynamic_main_flutter_channel";
  private MethodChannel jsFlutterAppChannel;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    init();
  }

  @Override
  protected void onDestroy() {
    super.onDestroy();
    jsEngine.close();
  }

  private void init() {
    initChannel();
    initEngine();
  }

  private void initChannel() {
    jsFlutterAppChannel = new MethodChannel(this.getFlutterView(), MAIN_FLUTTER_CHANNEL_NAME);
    jsFlutterAppChannel.setMethodCallHandler(new MethodCallHandler() {
      @Override
      public void onMethodCall(MethodCall call, Result result) {
        switch (call.method) {
          case "callJsEvent":
            String event = call.argument("event");
            jsEngine.execute(new Runnable() {
              @Override
              public void run() {
                V8Array arg = new V8Array(jsEngine.runtime).push(event);
                jsEngine.runtime.executeVoidFunction("updateEvent", arg);
                arg.close();
              }
            });
            result.success("success");
            break;
          case "callJsRuntimeMain":
            jsEngine.close();
            jsEngine.init();
            initBasicJSRuntime();
            initScript();
            initMainScript();
            result.success("success");
            break;
          default:
            result.notImplemented();
        }
      }
    });
  }

  private void initEngine() {
    this.jsEngine = new JsEngine(this);
  }

  private void initBasicJSRuntime() {
    JavaVoidCallback nativePrint = new JavaVoidCallback() {
      @Override
      public void invoke(V8Object v8Object, V8Array args) {
        if (args.length() > 0) {
          System.out.println("[JS Print]: " + args.get(0).toString());
        }
      }
    };
    jsEngine.registerJavaMethod(nativePrint, "NativePrint");
  }

  private void initScript() {
    Map<String, String> methodMap = new HashMap<String, String>();
    methodMap.put("postJsonTree", "postJsonTree");
    NativeJSFlutterApp NativeJSFlutterApp = new NativeJSFlutterApp();
    jsEngine.registerNativeObject(NativeJSFlutterApp, methodMap);
    jsEngine.executeScriptPath("framework/index.js");
  }

  private void initMainScript() {
    jsEngine.executeMainScriptPath("main.js");
  }

  public class NativeJSFlutterApp {
    public void postJsonTree(V8Object jsObject) {
      System.out.println("[JSON]: " + jsObject.getString("data"));
      String jsonTree = jsObject.getString("data");

      // Methods marked with @UiThread must be executed on the main thread.
      runOnUiThread(new Runnable() {
        @Override
        public void run() {
          jsFlutterAppChannel.invokeMethod("receiveJsonTree", jsonTree);
        }
      });
    }
  }

}
