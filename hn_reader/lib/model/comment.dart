// To parse this JSON data, do
//
//     final comment = commentFromJson(jsonString);

import 'dart:convert';

Comment commentFromJson(String str) => Comment.fromJson(json.decode(str));

String commentToJson(Comment data) => json.encode(data.toJson());

class Comment {
  Comment({
    this.by,
    this.id,
    this.kids,
    this.parent,
    this.text,
    this.time,
    this.type,
  });

  String by;
  int id;
  List<int> kids;
  int parent;
  String text;
  int time;
  String type;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    by: json["by"],
    id: json["id"],
    kids: List<int>.from(json["kids"].map((x) => x)),
    parent: json["parent"],
    text: json["text"],
    time: json["time"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "by": by,
    "id": id,
    "kids": List<dynamic>.from(kids.map((x) => x)),
    "parent": parent,
    "text": text,
    "time": time,
    "type": type,
  };
}
