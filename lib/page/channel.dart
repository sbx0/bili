import 'package:flutter/material.dart';

class Channel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('频道'),
      ),
      body: new Center(
        child: new RaisedButton(
          child: new Text('频道'),
          onPressed: () {
            // Navigate to second screen when tapped!
          },
        ),
      ),
    );
  }
}
