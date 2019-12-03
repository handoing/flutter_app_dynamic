import 'package:flutter/material.dart';

EdgeInsetsGeometry parseEdgeInsetsGeometry(String edgeInsetsGeometryString) {
  if (edgeInsetsGeometryString == null ||
      edgeInsetsGeometryString.trim() == '') {
    return null;
  }
  var values = edgeInsetsGeometryString.split(",");
  return EdgeInsets.only(
      left: double.parse(values[0]),
      top: double.parse(values[1]),
      right: double.parse(values[2]),
      bottom: double.parse(values[3]));
}

MainAxisAlignment parseMainAxisAlignment(String mainAxisAlignmentString) {
  MainAxisAlignment mainAxisAlignment = MainAxisAlignment.center;
  switch (mainAxisAlignmentString) {
    case 'MainAxisAlignment.spaceAround':
      mainAxisAlignment = MainAxisAlignment.spaceAround;
      break;
    case 'MainAxisAlignment.center':
      mainAxisAlignment = MainAxisAlignment.center;
      break;
    case 'MainAxisAlignment.end':
      mainAxisAlignment = MainAxisAlignment.end;
      break;
    case 'MainAxisAlignment.spaceBetween':
      mainAxisAlignment = MainAxisAlignment.spaceBetween;
      break;
    case 'MainAxisAlignment.spaceEvenly':
      mainAxisAlignment = MainAxisAlignment.spaceEvenly;
      break;
    case 'MainAxisAlignment.start':
      mainAxisAlignment = MainAxisAlignment.start;
      break;
  }
  return mainAxisAlignment;
}

CrossAxisAlignment parseCrossAxisAlignment(String crossAxisAlignmentString) {
  CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center;
  switch (crossAxisAlignmentString) {
    case 'CrossAxisAlignment.center':
      crossAxisAlignment = CrossAxisAlignment.center;
      break;
    case 'CrossAxisAlignment.end':
      crossAxisAlignment = CrossAxisAlignment.end;
      break;
    case 'CrossAxisAlignment.start':
      crossAxisAlignment = CrossAxisAlignment.start;
      break;
  }
  return crossAxisAlignment;
}

IconData parseIcon(String typeString) {
  IconData type = Icons.add;
  switch (typeString) {
    case 'add':
      type = Icons.add;
      break;
    case 'remove':
      type = Icons.remove;
      break;
  }
  return type;
}

MainAxisSize parseMainAxisSize(String mainAxisSizeString) => mainAxisSizeString == 'MainAxisSize.min' ? MainAxisSize.min : MainAxisSize.max;

EdgeInsets parsePadding(node) {
  switch (node['type']) {
    case 'symmetric':
      return EdgeInsets.symmetric(
        vertical: node['vertical'] == null ? 0.0 : double.parse(node['vertical'].toString()),
        horizontal: node['horizontal'] == null ? 0.0 : double.parse(node['horizontal'].toString()),
      );
    default:
      return EdgeInsets.all(0);
  }
}