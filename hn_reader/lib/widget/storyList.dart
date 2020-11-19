import 'package:flutter/material.dart';
import 'package:hn_reader/model/story.dart';
import 'package:hn_reader/widget/progress.dart';
import 'package:hn_reader/widget/story.dart';
import 'package:http/http.dart' as http;

class StoryList extends StatelessWidget {
  final List<int> stories;
  final Map<int, Story> storyCache = new Map();

  StoryList(this.stories);

  Future<Story> loadStory(int index) {
    if (index > stories.length-1) {
      return null;
    }
    return stories.contains(index)?storyCache[index]:
        http.get(
            'https://hacker-news.firebaseio.com/v0/item/${stories[index]}.json')
        .then((resp) {
          Story story = storyFromJson(resp.body);
          storyCache[index] = story;
          return story;
        });
  }

  Widget story(index) {
    return new FutureBuilder<Story>(
      future: loadStory(index),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return new ProgressCard();
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


  @override
  Widget build(BuildContext context) {
    return new Container(
        padding: new EdgeInsets.all(20.0),
        child: new ListView.builder(
            itemBuilder: (context, index) => index>stories.length-1?null:story(index)));
  }
}
