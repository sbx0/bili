import 'package:flutter/material.dart';
import 'package:bili/page/list.dart';

class Article extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('bili'),
        backgroundColor: Colors.pink,
      ),
      body: new AricleList(),
    );
  }
}
