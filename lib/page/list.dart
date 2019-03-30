import 'package:bili/entity/article.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import "package:pull_to_refresh/pull_to_refresh.dart";

Map<String, dynamic> data;
List<dynamic> objects;
List<Article> cache;
List<Article> datas;

class ArticleCard extends StatelessWidget {
  final Article article;

  ArticleCard(this.article);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          print(article.id);
        },
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 10.0, right: 10.0),
          leading: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 6.0),
                child: Text(article.id < 10
                    ? '0${article.id.toString()}'
                    : article.id.toString()),
              ),
            ],
          ),
          title: Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text(
              article.title,
              maxLines: 2,
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.deepPurple, fontSize: 16.0),
            ),
          ),
          subtitle: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Text(
                  '发布日期:',
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Text(
                  article.time,
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
            ],
          ),
          trailing: Text(
            article.author.name.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}

class AricleList extends StatefulWidget {
  @override
  _AricleListState createState() => _AricleListState();
}

class _AricleListState extends State {
  int page;
  ScrollController _scrollController = new ScrollController();
  RefreshController _refreshController = new RefreshController();

  @override
  void initState() {
    super.initState();
    page = 1;
    _getData(page);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: _onRefresh,
        child: cache == null
            ? ListView(
                children: <Widget>[Center(child: CircularProgressIndicator())],
              )
            : ListView.builder(
                itemCount: cache.length,
                itemBuilder: (BuildContext context, int i) {
                  return ArticleCard(cache[i]);
                },
              ));
  }

  void _onRefresh(bool up) {
    if (up) {
      new Future.delayed(const Duration(milliseconds: 1000)).then((val) {
        _getData(1);
        setState(() {
          _refreshController.sendBack(true, RefreshStatus.completed);
        });
      });
    } else {
      new Future.delayed(const Duration(milliseconds: 1000)).then((val) {
        _getData(page + 1);
        setState(() {
          _refreshController.sendBack(false, RefreshStatus.idle);
        });
      });
    }
  }

  void _getData(int p) async {
    try {
      Response response = await Dio().get(
          'http://zb.sbx0.cn/article/normal/list?page=' +
              p.toString() +
              '&size=10&attribute=time&direction=DESC');
      objects = json.decode(response.toString())['objects'];
      if (objects != null) {
        datas = objects.map((json) => Article.fromJson(json)).toList();
        if (p != 1)
          cache += datas;
        else
          cache = datas;
        setState(() {});
        page = p;
      }
    } catch (e) {
      print(e);
    }
  }
}
