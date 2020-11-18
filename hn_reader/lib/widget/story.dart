import 'package:flutter/material.dart';
import 'package:hn_reader/model/story.dart';
import 'package:url_launcher/url_launcher.dart';

class StoryCard extends StatelessWidget {
  final Story story;

  const StoryCard({
    Key key,
    this.story,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: InkWell(
          splashColor: Color(0xFFCC0000),
          onTap: () {
            _launchURL(story.url);
          },
          child: Container(
            alignment: AlignmentDirectional.center,
            height: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    flex: 4,
                    child: Padding(padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20), child:Text('${story.title}', textAlign: TextAlign.left, style: TextStyle(fontSize: 20)))),
                Flexible(
                    flex: 1,
                    child:
                    Padding(padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10), child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_upward),
                        Text('${story.score}',
                            style: TextStyle(color: Colors.black54)),
                        Icon(Icons.arrow_downward),
                      ],
                    ))
                    )
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
