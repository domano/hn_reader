// To parse this JSON data, do
//
//     final story = storyFromJson(jsonString);

import 'dart:convert';

Story storyFromJson(String str) => Story.fromJson(json.decode(str));

String storyToJson(Story data) => json.encode(data.toJson());

class Story {
  Story({
    this.by,
    this.descendants,
    this.id,
    this.kids,
    this.score,
    this.time,
    this.title,
    this.type,
    this.url,
  });

  String by;
  int descendants;
  int id;
  List<int> kids;
  int score;
  int time;
  String title;
  String type;
  String url;

  factory Story.fromJson(Map<String, dynamic> json) => Story(
    by: json["by"],
    descendants: json["descendants"],
    id: json["id"],
    kids: List<int>.from(json["kids"].map((x) => x)),
    score: json["score"],
    time: json["time"],
    title: json["title"],
    type: json["type"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "by": by,
    "descendants": descendants,
    "id": id,
    "kids": List<dynamic>.from(kids.map((x) => x)),
    "score": score,
    "time": time,
    "title": title,
    "type": type,
    "url": url,
  };
}
