import 'package:flutter/services.dart';
import 'package:sum_game/difficultyButton.dart';
import 'package:sum_game/gameWidget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  bool onStartScreen = true;
  var gameDifficulty;
  var increment;
  var minValue;
  var maxValue;

  void easyMode() {
    setState(() {
      onStartScreen = false;
      gameDifficulty = 3;
      increment = 0;
      minValue = 1;
      maxValue = 40;
    });
  }

  void mediumMode() {
    setState(() {
      onStartScreen = false;
      gameDifficulty = 4;
      increment = 1;
      minValue = 41;
      maxValue = 59;
    });
  }

  void hardMode() {
    setState(() {
      onStartScreen = false;
      gameDifficulty = 3;
      increment = 1;
      minValue = 101;
      maxValue = 99;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Number sum game'),
        ),
        body: (onStartScreen)
            ? Container(
                width: double.infinity,
                margin: EdgeInsets.all(30),
                child: ListView(
                  children: <Widget>[
                    Text(
                      'Welcome to the sum game!',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Container(margin: EdgeInsets.all(20)),
                    Text(
                      'Choose the difficulty:',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                    ),
                    DifficultyButton(easyMode, 'EASY'),
                    DifficultyButton(mediumMode, 'MEDIUM'),
                    DifficultyButton(hardMode, 'HARD'),
                  ],
                ),
              )
            : GameWidget(gameDifficulty, increment,
                () => setState(() => onStartScreen = true), minValue, maxValue),
      ),
    );
  }
}
