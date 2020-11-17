import 'package:flutter/material.dart';
import 'package:hn_reader/model/story.dart';
import 'package:hn_reader/widget/story.dart';
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
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new CircularProgressIndicator();
          default:
            if (snapshot.hasError) {
              return new Text("${snapshot.error}");
            }
            return StoryCard(
                key: Key(snapshot.data.id.toString()), story: snapshot.data);
        }
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
