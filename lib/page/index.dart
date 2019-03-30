import 'package:flutter/material.dart';

class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new TopBar(),
        backgroundColor: Colors.pink,
      ),
      body: new Body(),
    );
  }
}

// 页面顶部
class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        Container(
          child: new Icon(Icons.menu),
          height: 30,
          width: 30,
          margin: const EdgeInsets.only(right: 10.0),
        ),
        Container(
          child: new CircleAvatar(
            backgroundImage: new NetworkImage(
                'http://zb.sbx0.cn/upload/image/20190328144254868.jpg'),
            radius: 15,
          ),
          margin: const EdgeInsets.only(right: 10.0),
        ),
        Container(
          child: new InputChip(
            backgroundColor: Colors.redAccent,
            avatar: new Icon(Icons.search, color: Colors.pink),
            label: new Text('搜索'),
          ),
          margin: const EdgeInsets.only(right: 10.0),
        )
      ],
    );
  }
}

class Body extends StatefulWidget {
  @override
  _Body createState() {
    return new _Body();
  }
}

class _Body extends State with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;
  List<String> tabs;

  @override
  void initState() {
    tabs = [
      '直播',
      '推荐',
      '热门',
      '番剧',
    ];
    _tabController = new TabController(
      length: 4,
      vsync: this,
    );
    _scrollController = new ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: <Widget>[
          new Container(
            foregroundDecoration: new BoxDecoration(
              border: new Border(
                bottom: BorderSide(
                    color: Colors.grey, width: 0.1, style: BorderStyle.solid),
              ),
            ),
            child: new Center(
              child: TabBar(
                controller: _tabController,
                isScrollable: true,
                labelColor: Colors.red,
                indicatorColor: Colors.pink,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 3,
                unselectedLabelColor: Color(0xff666666),
                labelStyle: TextStyle(fontSize: 16.0),
                tabs: tabs.map((item) {
                  return Tab(
                    text: item,
                  );
                }).toList(),
              ),
            ),
          ),
          new VideoCard(
            'https://i0.hdslb.com/bfs/archive/20d550e2843f3cb4bb1293c857357d570da87d87.jpg@200w_125h.webp',
            '06:21 508 观看 1 弹幕',
            'https://i1.hdslb.com/bfs/face/c63ebeed7d49967e2348ef953b539f8de90c5140.jpg@160w_160h.webp',
            '比《复联4》更虐！漫威不敢拍的复联10次团灭',
          ),
          new VideoCard(
            'https://i0.hdslb.com/bfs/archive/6a7d539c3d71c516fa9b06a692d175bdce84a711.jpg@320w_200h.webp',
            '06:21 508 观看 1 弹幕',
            'http://zb.sbx0.cn/upload/image/20190328144254868.jpg',
            '随机挑战！这是我做过最后悔的决定了！',
          ),
          new VideoCard(
            'https://i0.hdslb.com/bfs/archive/6a7d539c3d71c516fa9b06a692d175bdce84a711.jpg@320w_200h.webp',
            '06:21 508 观看 1 弹幕',
            'http://zb.sbx0.cn/upload/image/20190328144254868.jpg',
            '随机挑战！这是我做过最后悔的决定了！',
          )
        ],
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final String cover;
  final String status;
  final String avatar;
  final String title;

  VideoCard(this.cover, this.status, this.avatar, this.title);

  @override
  Widget build(BuildContext context) {
    return new Card(
      elevation: 0,
      shape: Border(
        left: BorderSide(
            color: Colors.grey, width: 0.1, style: BorderStyle.solid),
        right: BorderSide(
            color: Colors.grey, width: 0.1, style: BorderStyle.solid),
        top: BorderSide(
            color: Colors.grey, width: 0.1, style: BorderStyle.solid),
        bottom: BorderSide(
            color: Colors.grey, width: 0.1, style: BorderStyle.solid),
      ),
      margin: EdgeInsets.only(top: 5, bottom: 10, right: 10, left: 10),
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width - 20,
                    height:
                        (MediaQuery.of(context).size.width - 20) * (200 / 320) -
                            50,
                    child: new Image(
                      fit: BoxFit.cover,
                      image: NetworkImage(cover),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: (MediaQuery.of(context).size.width - 20) *
                                (200 / 320) -
                            75),
                    padding: EdgeInsets.only(left: 10),
                    width: (MediaQuery.of(context).size.width - 20) * 0.5,
                    height: 25,
                    child: new Text(
                      status,
                      style: TextStyle(
                        fontSize: 12,
                        shadows: <Shadow>[
                          new Shadow(
                              offset: Offset(0, 0),
                              blurRadius: 3,
                              color: Colors.black)
                        ],
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                      maxLines: 1,
                    ),
                  ),
                ],
              )
            ],
          ),
          new Row(
            children: <Widget>[
              Container(
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(avatar),
                  radius: 16,
                ),
                margin: const EdgeInsets.only(
                    right: 5.0, left: 5.0, top: 5, bottom: 5),
              ),
              new Flexible(
                child: new Center(
                  child: new Text(
                    title,
                    textAlign: TextAlign.left,
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: new TextStyle(
                      decorationColor: const Color(0xffffffff),
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                flex: 1,
              ),
              Container(
                child: new Icon(Icons.more_horiz),
                height: 30,
                width: 30,
                margin: const EdgeInsets.only(right: 10.0),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
