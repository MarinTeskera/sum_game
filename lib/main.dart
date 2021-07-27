import 'dart:math';

import 'package:sum_game/numButton.dart';
import 'package:sum_game/question.dart';
import 'package:sum_game/resetButton.dart';
import 'package:sum_game/sumText.dart';
import 'package:flutter/material.dart';
//TODO: implement scrollable change

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  bool isPlaying = true;
  Random generator = Random();

  int sum = 0;
  int neededNum = Random().nextInt(150);
  int steps = 0;

  List addedNums = [
    Random().nextInt(5) + 1,
    Random().nextInt(5) + 5,
    Random().nextInt(5) + 10
  ];
  List subtractedNums = [
    Random().nextInt(5) + 1,
    Random().nextInt(5) + 5,
    Random().nextInt(5) + 10
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
      neededNum = generator.nextInt(150);

      addedNums = [
        Random().nextInt(5) + 1,
        Random().nextInt(5) + 5,
        Random().nextInt(5) + 10
      ];
      subtractedNums = [
        Random().nextInt(5) + 1,
        Random().nextInt(5) + 5,
        Random().nextInt(5) + 10
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
            ? Column(
                children: <Widget>[
                  Question('GET TO $neededNum'),
                  ...addedNums.map((n) {
                    return NumButton(
                        '+' + n.toString(), addNum, n, Colors.blue);
                  }).toList(),
                  ...subtractedNums.map((n) {
                    return NumButton(
                        '-' + n.toString(), subtractNum, n, Colors.red);
                  }).toList(),
                  /* ResetButton(resetText, resetSum), */
                  SumText('CURRENT SUM: $sum'),
                  Text(
                    'STEPS TAKEN: $steps',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              )
            : Column(children: <Widget>[
                Question('Well done!'),
                Text('It took you $steps steps'),
                ElevatedButton(onPressed: goBack, child: Text('Play again'))
              ]),
      ),
    );
  }
}
