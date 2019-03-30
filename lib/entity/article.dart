import 'package:bili/entity/Tag.dart';
import 'package:bili/entity/User.dart';

List<dynamic> objects;

class Article {
  final int id;
  final String title;
  final String time;
  final String introduction;
  final String content;
  final int top;
  final User author;
  final List<Tag> tags;

  Article({
    this.id,
    this.title,
    this.time,
    this.introduction,
    this.content,
    this.top,
    this.author,
    this.tags,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] as int,
      title: json['title'] as String,
      time: json['time'] as String,
      introduction: json['introduction'] as String,
      content: json['content'] as String,
      top: json['top'] as int,
      author: User.fromJson(json['author']),
    );
  }
}
