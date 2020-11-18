import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

class ProgressCard extends StatelessWidget {

  const ProgressCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MirrorAnimation<Color>(
        tween: Colors.white.tweenTo(Colors.white70),
        duration: 200.milliseconds,
        curve: Curves.easeInOutSine, // <-- optional

        builder: (context, child, value) {
          //Center(

          return Card(
            color: value,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white70, Colors.white12])),
              height: 150,
              child:  Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [LinearProgressIndicator(minHeight: 20,),Text("Loading..."),],)
            ),
          );
        });
  }
}
