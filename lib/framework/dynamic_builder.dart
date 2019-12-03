import 'package:flutter/material.dart';
import 'package:flutter_app_dynamic/framework/framework_owner.dart';
import 'package:flutter_app_dynamic/framework/attribute_parser.dart';

class StateWidgetParser {
  Widget parse(Map node) {
    Widget child = node['child'] == null ? null : DynamicWidgetBuilder.buildWidget(node['child']);
    return child;
  }
}

class ScaffoldWidgetParser {
  Widget parse(Map node) {
    Widget appBar = node['appBar'] == null ? null : DynamicWidgetBuilder.buildWidget(node['appBar']);
    Widget body = node['body'] == null ? null : DynamicWidgetBuilder.buildWidget(node['body']);
    Widget floatingActionButton = node['floatingActionButton'] == null ? null : DynamicWidgetBuilder.buildWidget(node['floatingActionButton']);

    return Scaffold(
        appBar: appBar,
        body: body,
        floatingActionButton: floatingActionButton
    );
  }
}

class AppBarWidgetParser {
  Widget parse(Map node) {
    Widget title = node['title'] == null ? null : DynamicWidgetBuilder.buildWidget(node['title']);

    return AppBar(
      title: title,
    );
  }
}

class TextWidgetParser {
  Widget parse(Map node) {
    return Text(node['text']);
  }
}

class PaddingWidgetParser {
  Widget parse(Map node) {
    Widget child = node['child'] == null ? null : DynamicWidgetBuilder.buildWidget(node['child']);
    return Padding(
      padding: parsePadding(node['padding']),
      child: child,
    );
  }
}

class FloatingActionButtonWidgetParser {
  Widget parse(Map node) {
    Widget child = node['child'] == null ? null : DynamicWidgetBuilder.buildWidget(node['child']);
    return FloatingActionButton(
      tooltip: node['tooltip'],
      onPressed: () {
        FrameworkEventOwner.invoke(node['onPressed']);
      },
      child: child,
    );
  }
}

class IconWidgetParser {
  Widget parse(Map node) {
    return Icon(parseIcon(node['icon']));
  }
}

class CenterWidgetParser {
  Widget parse(Map node) {
    Widget child = node['child'] == null ? null : DynamicWidgetBuilder.buildWidget(node['child']);
    return Center(
      child: child,
    );
  }
}

class ColumnWidgetParser {
  Widget parse(Map node) {
    List<Widget> children = node['children'] == null ? null : DynamicWidgetBuilder.buildListWidget(node['children']);
    return Column(
      mainAxisSize: parseMainAxisSize(node['mainAxisSize']),
      mainAxisAlignment: parseMainAxisAlignment(node['mainAxisAlignment']),
      crossAxisAlignment: parseCrossAxisAlignment(node['crossAxisAlignment']),
      children: children,
    );
  }
}

class GestureDetectorWidgetParser {
  Widget parse(Map node) {
    Widget child = node['child'] == null ? null : DynamicWidgetBuilder.buildWidget(node['child']);
    return GestureDetector(
      onTap: () {
        FrameworkEventOwner.invoke(node['onTap']);
      },
      child: child,
    );
  }
}

class ContainerWidgetParser {
  Widget parse(Map node) {
    Widget child = node['child'] == null ? null : DynamicWidgetBuilder.buildWidget(node['child']);
    return Container(
        child: child
    );
  }
}

class DynamicWidgetBuilder {
  static final _parsers = {
    'StateWidget': StateWidgetParser(),
    'Scaffold': ScaffoldWidgetParser(),
    'AppBar': AppBarWidgetParser(),
    'Text': TextWidgetParser(),
    'Column': ColumnWidgetParser(),
    'GestureDetector': GestureDetectorWidgetParser(),
    'Container': ContainerWidgetParser(),
    'Center': CenterWidgetParser(),
    'Icon': IconWidgetParser(),
    'FloatingActionButton': FloatingActionButtonWidgetParser(),
    'Padding': PaddingWidgetParser(),
  };

  static Widget buildWidget(node) {
    String widgetName = node['widgetName'];
    dynamic parser = _parsers[widgetName];

    if (_parsers[widgetName] != null) {
      return parser.parse(node);
    }

    return null;
  }

  static List<Widget> buildListWidget(List children) {
    List<Widget> list = [];

    children.forEach((node) {
      list.add(buildWidget(node));
    });

    return list;
  }
}