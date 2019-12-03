class CustomWidget extends StateWidget {
  constructor(count) {
    super();
    this.state = {
        count: count * 2
    }
  }

  build() {
    return new Text(`${this.state.count}`);
  }
}

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

if (isBrowser) {
  main();
}