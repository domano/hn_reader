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
            height: 100,
            alignment: AlignmentDirectional.center,

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.article, size: 30, ),
                  title: Text('${story.title}', textAlign: TextAlign.left,),

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

