import 'package:flutter/material.dart';
import 'package:hn_reader/model/story.dart';
import 'package:url_launcher/url_launcher.dart';

class StoryCard extends StatelessWidget {
  final Story story;

  const StoryCard({
    Key key, this.story,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            _launchURL(story.url);
          },
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.article),
                  title: Text('${story.title}'),
                  subtitle: Text(
                      '${DateTime.fromMillisecondsSinceEpoch(story.time)}'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

