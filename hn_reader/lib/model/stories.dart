// To parse this JSON data, do
//
//     final stories = storiesFromJson(jsonString);

import 'dart:convert';

List<int> storiesFromJson(String str) => List<int>.from(json.decode(str).map((x) => x));

String storiesToJson(List<int> data) => json.encode(List<dynamic>.from(data.map((x) => x)));
