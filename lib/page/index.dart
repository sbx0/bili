import 'package:bili/entity/demand.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

// 首页
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

// TODO 下拉刷新

// 身体
class Body extends StatefulWidget {
  @override
  _Body createState() {
    return new _Body();
  }
}

// 身体
class _Body extends State with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<String> tabs;
  int page = 0;
  List<dynamic> objects;
  List<Demand> cache;
  List<Demand> datas;
  List<Widget> videos = [];

  void _getData(int p) async {
    try {
      Response response = await Dio().get(
          'http://zb.sbx0.cn/demand/normal/list?page=' +
              p.toString() +
              '&size=3&attribute=time&direction=DESC');
      objects = json.decode(response.toString())['objects'];
      if (objects != null) {
        datas = objects.map((json) => Demand.fromJson(json)).toList();
        if (p != 1)
          cache += datas;
        else
          cache = datas;
        videos = [];
        for (Demand d in cache) {
          videos.insert(
            0,
            new VideoCard(d.cover, d.time,
                'http://zb.sbx0.cn/' + d.poster.avatar, d.title),
          );
        }
        setState(() {});
        page = p;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _onRefresh() async {
    await Future.delayed(Duration(seconds: 1), () {
      print('refresh' + page.toString());
      _getData(++page);
      setState(() {});
    });
  }

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
    _getData(page + 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> body = [
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
    ];

    body.addAll(videos);

    return RefreshIndicator(
        onRefresh: _onRefresh,
        child: new SingleChildScrollView(
          child: Column(
            children: body,
          ),
        ));
  }
}

// 视频卡
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
