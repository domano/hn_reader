import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  const ProgressCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white60,
      child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white70, Colors.white12])),
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              LinearProgressIndicator(
                minHeight: 15,
              ),
              Text("Loading..."),
            ],
          )),
    );
  }
}
