import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/ui/homescreen.dart';
import 'package:flutter_app/util/myRouter.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => new _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, _home);
  }

  void _home() => myRouter.makeFirst(context, HomeScreen());

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Icon(Icons.sports_soccer, size: 100,),
      ),
    );
  }
}