import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model/stories.dart';
import 'widget/storyList.dart';

void main() {
  runApp(MyApp());
}

const routeMap = {
  0:"/topstories",
  1:"/askstories",
  2:"/showstories",
};

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'tarent Hacker News',
      theme: ThemeData(
        primarySwatch: _createMaterialColor(Color(0xFFCC0000)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: "/topstories",
      routes: {
        "/topstories": (context) => Stories("Top Stories",
            "https://hacker-news.firebaseio.com/v0/topstories.json", 0),
        "/askstories": (context) => Stories("Top AskHN Threads",
            "https://hacker-news.firebaseio.com/v0/askstories.json", 1),
        "/showstories": (context) => Stories("Top ShowHN Posts",
            "https://hacker-news.firebaseio.com/v0/showstories.json", 2),
      },
    );
  }
}

class Stories extends StatefulWidget {
  String title;
  String url;
  int index;

  Stories(this.title, this.url, this.index);

  @override
  _StoriesState createState() => _StoriesState(title, url, index);
}

class _StoriesState extends State<Stories> {
  String title;
  String url;
  int index;

  _StoriesState(this.title, this.url, this.index);

  Future<List<int>> loadStories() {
    return http.get(url).then((resp) => storiesFromJson(resp.body));
  }

  Widget storyList() {
    return new FutureBuilder<List<int>>(
      future: loadStories(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return StoryList(snapshot.data);
        } else if (snapshot.hasError) {
          return new Text("${snapshot.error}");
        }
        return new CircularProgressIndicator();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(this.title),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: index, // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
                icon: new Icon(Icons.article),
                label: "Stories"),
            BottomNavigationBarItem(
              icon: new Icon(Icons.question_answer),
              label: "Ask",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wb_iridescent),
              label: "Show",
            )
          ], onTap: (i) => Navigator.pushNamed(context, routeMap[i]),
        ),
        body: Center(child: storyList()));
  }
}

MaterialColor _createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
