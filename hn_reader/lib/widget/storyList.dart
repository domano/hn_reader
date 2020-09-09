import 'package:flutter/material.dart';
import 'package:hn_reader/model/story.dart';
import 'package:http/http.dart' as http;

class StoryList extends StatelessWidget {
  final List<int> stories;
  final Map<int, String> titles = new Map();

  StoryList(this.stories);

  Future<Story> loadStory(int index) {
    return http
        .get(
            'https://hacker-news.firebaseio.com/v0/item/${stories[index]}.json')
        .then((resp) => storyFromJson(resp.body));
  }

  Widget story(index) {
    return new FutureBuilder<Story>(
      future: loadStory(index),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            height: 50,
            color: Colors.amber[600],
            child: Center(child: Text('${snapshot.data.title}')),
          );
        } else if (snapshot.hasError) {
          return new Text("${snapshot.error}");
        }
        return new CircularProgressIndicator();
      },
    );
  }

/*  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: new EdgeInsets.all(20.0),
        child: new ListView(
            children:
            stories.map((storyId) =>
                Container(
                  height: 50,
                  color: Colors.amber[600],
                  child: Center(child: Text('$storyId')),
                ),
            ).toList()));
  }*/

  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: new EdgeInsets.all(20.0),
        child: new ListView.builder(
            itemBuilder: (context, index) => story(index)));
  }
}
