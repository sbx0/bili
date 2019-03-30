import 'package:bili/page/article.dart';
import 'package:flutter/material.dart';
import 'package:bili/page/index.dart';
import 'package:bili/page/channel.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    new PlaceholderWidget('首页'),
    new PlaceholderWidget('频道'),
    new PlaceholderWidget('动态'),
    new PlaceholderWidget('文章'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: new BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 20.0,
        fixedColor: Colors.pink,
        items: [
          new BottomNavigationBarItem(
              title: Text(
                '首页',
                style: new TextStyle(fontSize: 13),
              ),
              icon: Icon(Icons.home)),
          new BottomNavigationBarItem(
              title: Text(
                '频道',
                style: new TextStyle(fontSize: 13),
              ),
              icon: Icon(Icons.tv)),
          new BottomNavigationBarItem(
              title: Text(
                '动态',
                style: new TextStyle(fontSize: 13),
              ),
              icon: Icon(Icons.alternate_email)),
          new BottomNavigationBarItem(
              title: Text(
                '文章',
                style: new TextStyle(fontSize: 13),
              ),
              icon: Icon(Icons.library_books)),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

class PlaceholderWidget extends StatelessWidget {
  final String text;

  PlaceholderWidget(this.text);

  @override
  Widget build(BuildContext context) {
    switch (text) {
      case '首页':
        return new Index();
        break;
      case '频道':
        return new Channel();
        break;
      case '动态':
        return new Index();
        break;
      case '文章':
        return new Article();
        break;
      default:
        return new Index();
    }
  }
}
