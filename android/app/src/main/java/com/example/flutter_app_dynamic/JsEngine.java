package com.example.flutter_app_dynamic;

import android.content.Context;

import com.eclipsesource.v8.JavaVoidCallback;
import com.eclipsesource.v8.V8;
import com.eclipsesource.v8.V8Object;

import java.util.Map;
import java.util.concurrent.Executor;
import java.util.concurrent.Executors;

public class JsEngine {

    public V8 runtime;

    private Executor executor;

    private Context context;

    public JsEngine(Context context) {
        this.context = context;
        this.executor = Executors.newSingleThreadExecutor();
        init();
    }

    private void init() {
        executor.execute(new Runnable() {
            @Override
            public void run() {
                runtime = V8.createV8Runtime();
                runtime.add("Platform", "android");
            }
        });
    }

    public void execute(Runnable action) {
        try {
            executor.execute(action);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void registerNativeObject(MainActivity.NativeJSFlutterApp nativeJSFlutterApp, Map<String, String> methodMap) {
        try {
            executor.execute(new Runnable() {
                @Override
                public void run() {
                    V8Object v8Object = new V8Object(runtime);
                    runtime.add("NativeJSFlutterApp", v8Object);
                    for (Map.Entry<String, String> entry : methodMap.entrySet()) {
                        v8Object.registerJavaMethod(nativeJSFlutterApp, entry.getKey(), entry.getValue(), new Class<?>[]{ V8Object.class });
                    }
                    v8Object.close();
                }
            });
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void executeMainScriptPath(String path) {
        try {
            executor.execute(new Runnable() {
                @Override
                public void run() {
                    String script = FileUtils.getFromAssets(context, path) + "\nmain();";
                    V8Object result = runtime.executeObjectScript(script);
                    result.close();
                }
            });
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void executeScriptPath(String path) {
        try {
            executor.execute(new Runnable() {
                @Override
                public void run() {
                    String script = FileUtils.getFromAssets(context, path);
                    V8Object result = runtime.executeObjectScript(script);
                    result.close();
                }
            });
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void executeScript(String script) {
        try {
            executor.execute(new Runnable() {
                @Override
                public void run() {
                    Object result = runtime.executeScript(script);
                }
            });
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void registerJavaMethod(JavaVoidCallback callback, String name) {
        try {
            executor.execute(new Runnable() {
                @Override
                public void run() {
                    runtime.registerJavaMethod(callback, name);
                }
            });
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void close() {
        executor.execute(new Runnable() {
            @Override
            public void run() {
                if (runtime != null) {
                    try {
                        runtime.close();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        });
    }
}
