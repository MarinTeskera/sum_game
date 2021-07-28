import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sum_game/question.dart';
import 'package:sum_game/resetButton.dart';
import 'package:sum_game/sumText.dart';

import 'numButton.dart';

class GameWidget extends StatefulWidget {
  final int diff;
  GameWidget(this.diff);

  @override
  _GameWidgetState createState() => _GameWidgetState(diff);
}

class _GameWidgetState extends State<GameWidget> {
  final int diff;
  _GameWidgetState(this.diff);

  bool isPlaying = true;

  int sum = 0;
  int neededNum = Random().nextInt(150) + 50;
  int steps = 0;

  List addedNums = [];
  List subtractedNums = [];

  void fillLists(int n) {
    addedNums = [];
    subtractedNums = [];

    for (var i = 0; i < n; i++) {
      int added = Random().nextInt(5) + i * 5 + 1;
      int subtracted = Random().nextInt(5) + i * 5 + 1;

      while (subtracted == added) {
        subtracted = Random().nextInt(5) + i * 5 + 1;
      }

      addedNums.add(added);
      subtractedNums.add(subtracted);
    }
  }

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
      neededNum = Random().nextInt(150) + 50;

      List addedNums = [];
      List subtractedNums = [];

      fillLists(diff);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (addedNums.isEmpty) {
      fillLists(diff);
    }

    return (isPlaying)
        ? ListView(
            children: <Widget>[
              Question('GET TO $neededNum', 28),
              ...addedNums.map((n) {
                return NumButton('+' + n.toString(), addNum, n, Colors.blue);
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
          ]);
  }
}
