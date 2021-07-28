import 'dart:math';

import 'package:flutter/services.dart';
import 'package:sum_game/numButton.dart';
import 'package:sum_game/question.dart';
import 'package:sum_game/resetButton.dart';
import 'package:sum_game/sumText.dart';
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
  bool isPlaying = true;
  Random generator = Random();

  int sum = 0;
  int neededNum = Random().nextInt(150) + 50;
  int steps = 0;

  List addedNums = [
    Random().nextInt(5) + 1,
    Random().nextInt(5) + 6,
    Random().nextInt(5) + 11,
  ];
  List subtractedNums = [
    Random().nextInt(5) + 1,
    Random().nextInt(5) + 6,
    Random().nextInt(5) + 11
  ];

  Function addNum(int n) {
    return () => setState(() {
          steps++;
          sum += n;
          if (sum == neededNum) {
            isPlaying = false;
          }
        });
  }

  Function subtractNum(int n) {
    return () => setState(() {
          steps++;
          sum -= n;
          if (sum == neededNum) {
            isPlaying = false;
          }
        });
  }

  void goBack() {
    setState(() {
      isPlaying = true;
      sum = 0;
      steps = 0;
      neededNum = generator.nextInt(150) + 50;

      List addedNums = [
        Random().nextInt(5) + 1,
        Random().nextInt(5) + 6,
        Random().nextInt(5) + 11
      ];
      List subtractedNums = [
        Random().nextInt(5) + 1,
        Random().nextInt(5) + 6,
        Random().nextInt(5) + 11
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    addedNums.sort();
    subtractedNums.sort();

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Number sum game'),
        ),
        body: (isPlaying)
            ? ListView(
                children: <Widget>[
                  Question('GET TO $neededNum', 28),
                  ...addedNums.map((n) {
                    return NumButton(
                        '+' + n.toString(), addNum, n, Colors.blue);
                  }).toList(),
                  ...subtractedNums.map((n) {
                    return NumButton(
                        '-' + n.toString(), subtractNum, n, Colors.red);
                  }).toList(),
                  SumText('CURRENT SUM: $sum'),
                  SumText('STEPS TAKEN: $steps'),
                ],
              )
            : Column(children: <Widget>[
                Question('Well done!', 50),
                Text(
                  'It took you $steps steps',
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
                ResetButton(goBack, 'Play again'),
              ]),
      ),
    );
  }
}
