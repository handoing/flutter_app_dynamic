// base.js
const isBrowser = typeof Platform === 'undefined';

function print(message) {
  if (isBrowser) {
    console.log(message);
    return;
  }
  if (typeof message === 'string') {
    NativePrint(message);
    return;
  }
  NativePrint('Message is not of string type!');
}

if (isBrowser) {
  window.NativeJSFlutterApp = {
    postJsonTree: function (result) {
      print(JSON.parse(result.data));
    }
  }
}

// widget.js
class Scaffold {
  constructor(options) {
    this.widgetName = "Scaffold";
    this.appBar = options.appBar;
    this.body = options.body;
    this.floatingActionButton = options.floatingActionButton;
  }
}

class AppBar {
  constructor(options) {
    this.widgetName = "AppBar";
    this.title = options.title;
  }
}

class Icon {
  constructor(icon) {
    this.widgetName = "Icon";
    this.icon = icon;
  }
}

class Text {
  constructor(str) {
    this.widgetName = "Text";
    this.text = str;
  }
}

class Padding {
  constructor(options) {
    this.widgetName = "Padding";
    this.padding = options.padding;
    this.child = options.child;
  }
}

class Center {
  constructor(options) {
    this.widgetName = "Center";
    this.child = options.child;
  }
}

class Column {
  constructor(options) {
    this.widgetName = "Column";
    this.children = options.children;
    this.mainAxisSize = options.mainAxisSize;
    this.mainAxisAlignment = options.mainAxisAlignment;
    this.crossAxisAlignment = options.crossAxisAlignment;
  }
}

class GestureDetector {
  constructor(options) {
    this.widgetName = "GestureDetector";
    this.child = options.child;
    this.onTap = EventOwner.bindEvent(options.onTap);
  }
}

class FloatingActionButton {
  constructor(options) {
    this.widgetName = "FloatingActionButton";
    this.child = options.child;
    this.tooltip = options.tooltip;
    this.onPressed = EventOwner.bindEvent(options.onPressed);
  }
}

// attribute.js
const MainAxisAlignment = {
  start: "MainAxisAlignment.start",
  end: "MainAxisAlignment.end",
  center: "MainAxisAlignment.center",
  spaceBetween: "MainAxisAlignment.spaceBetween",
  spaceAround: "MainAxisAlignment.spaceAround",
  spaceEvenly: "MainAxisAlignment.spaceEvenly"
};

const MainAxisSize = {
  min: "MainAxisSize.min",
  max: "MainAxisSize.max"
};

const CrossAxisAlignment = {
  start: "CrossAxisAlignment.start",
  end: "CrossAxisAlignment.end",
  center: "CrossAxisAlignment.center",
  stretch: "CrossAxisAlignment.stretch",
  baseline: "CrossAxisAlignment.baseline"
};

const Icons = {
  add: "add",
  remove: "remove"
};

class EdgeInsets {
  constructor(left, top, right, bottom) {
    this.left = left;
    this.top = top;
    this.right = right;
    this.bottom = bottom;
  }
  static symmetric({
    vertical,
    horizontal
  } = {}) {
    return {
      type: "symmetric",
      vertical,
      horizontal
    };
  }
}

class StateWidget {
  constructor() {
    this.widgetName = "StateWidget";
  }

  setState(fun) {
    fun.call(this);
    EventOwner.clearEvent();
    buildOwner.updateWidget();
  }
}

// owner.js
var EventOwner = (function () {
  var id = 0;
  var idMap = {};
  var prefix = 'event';

  return {
    bindEvent: function (fun) {
      var eventKey = `${prefix}_${++id}`;
      idMap[eventKey] = fun;
      return eventKey;
    },
    getEventMap: function () {
      return idMap;
    },
    fireEvent: function (event) {
      idMap[event] && idMap[event]();
    },
    clearEvent: function () {
      id = 0;
      idMap = {};
    }
  }
})()

var buildOwner = (function () {
  var currentWidget = {};

  var supperTraversalKeys = [
    'child',
    'appBar',
    'body',
    'floatingActionButton'
  ];

  var toJSON = function () {
    var jsonTree = JSON.stringify(currentWidget);
    NativeJSFlutterApp.postJsonTree({
      data: jsonTree
    });
  }

  var traversal = function (node) {
    let nodes = [];

    if (node.widgetName == 'StateWidget') {
      node.child = node.build();
    }

    nodes.push[node];

    if (node.children) {
      let children = node.children;
      for (let i = 0; i < children.length; i++) {
        traversal(children[i]);
      }
    }

    supperTraversalKeys.forEach(function (key) {
      if (key in node) {
        traversal(node[key]);
      }
    })

    return nodes;
  }

  return {
    initWidget: function (widget) {
      currentWidget = widget;
      traversal(currentWidget);
      toJSON();
    },
    getCurrentWidget: function () {
      return currentWidget;
    },
    updateWidget: function () {
      traversal(currentWidget);
      toJSON();
    }
  }
})()

// index.js
function updateEvent(event) {
  EventOwner.fireEvent(event);
}

function runApp(widget) {
  buildOwner.initWidget(widget);
}