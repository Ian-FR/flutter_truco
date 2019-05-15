import 'package:flutter/material.dart';
import 'package:truco/screens/game_screen.dart';
import 'package:truco/screens/inicialization_screen.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Truco!',
      theme: ThemeData(primarySwatch: Colors.green),
      home: InitializationScreen(), // Route named '/'
      routes: <String, WidgetBuilder>{
        '/game': (BuildContext context) => GameScreen(),
      },
    );
  }
}