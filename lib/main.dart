import 'package:flutter/material.dart';
import 'package:bili/page/Body.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(title: 'bili', home: new Home());
  }
}
