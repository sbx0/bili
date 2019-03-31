import 'package:bili/entity/Tag.dart';
import 'package:bili/entity/User.dart';

List<dynamic> objects;

class Demand {
  final int id;
  final String title;
  final String time;
  final String cover;
  final String content;
  final int top;
  final User poster;
  final List<Tag> tags;

  Demand({
    this.id,
    this.title,
    this.time,
    this.cover,
    this.content,
    this.top,
    this.poster,
    this.tags,
  });

  factory Demand.fromJson(Map<String, dynamic> json) {
    return Demand(
      id: json['id'] as int,
      title: json['title'] as String,
      time: json['time'] as String,
      cover: json['cover'] as String,
      content: json['content'] as String,
      top: json['top'] as int,
      poster: User.fromJson(json['poster']),
    );
  }
}
