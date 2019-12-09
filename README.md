# flutter_app_dynamic

A dynamic Flutter application.

[![Platform](https://img.shields.io/badge/Platform-android-blue.svg)]()

## Getting Started

**1. `lib/main.dart`**

```dart
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
```

**2. `src/main.js`**

```js
class RootWidget extends StateWidget {
  constructor() {
    super();
    this.state = {
      count: 0
    };
  }

  increment() {
    this.setState(function () {
      this.state.count++;
    });
  }

  decrement() {
    this.setState(function () {
      this.state.count--;
    });
  }

  build() {
    let app = new Scaffold({
      appBar: new AppBar({
        title: new Text("Flutter Demo")
      }),
      body: new Center({
        child: new Column({
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Text('You have pushed the button this many times:'),
            new Text(`${this.state.count}`),
            new CustomWidget(this.state.count)
          ]
        })
      }),
      floatingActionButton: new Column({
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          new Padding({
            padding: EdgeInsets.symmetric({
              vertical: 5.0
            }),
            child: new FloatingActionButton({
              onPressed: this.increment.bind(this),
              tooltip: 'Increment',
              child: new Icon(Icons.add),
            }),
          }),
          new Padding({
            padding: EdgeInsets.symmetric({
              vertical: 5.0
            }),
            child: new FloatingActionButton({
              onPressed: this.decrement.bind(this),
              tooltip: 'Decrement',
              child: new Icon(Icons.remove),
            }),
          })
        ]
      })
    });

    return app;
  }
}

function main() {
  print('[runtime] main');
  runApp(new RootWidget());
}
```

## Note

flutter_app_dynamic is immature, only for learning.
