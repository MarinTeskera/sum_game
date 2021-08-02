import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sum_game/question.dart';
import 'package:sum_game/resetButton.dart';
import 'package:sum_game/sumText.dart';

import 'numButton.dart';

class GameWidget extends StatefulWidget {
  final int diff;
  final int increment;
  final Function returnFunction;
  final int minValue;
  final int maxValue;
  GameWidget(this.diff, this.increment, this.returnFunction, this.minValue,
      this.maxValue);

  @override
  _GameWidgetState createState() =>
      _GameWidgetState(diff, increment, returnFunction, minValue, maxValue);
}

class _GameWidgetState extends State<GameWidget> {
  final int diff;
  final int increment;
  var returnFunction;
  final int minValue;
  final int maxValue;
  _GameWidgetState(this.diff, this.increment, this.returnFunction,
      this.minValue, this.maxValue);

  bool isPlaying = true;

  int sum = 0;
  int steps = 0;
  int neededNum = 0;

  List addedNums = [];
  List subtractedNums = [];

  void fillLists() {
    addedNums = [];
    subtractedNums = [];

    for (var i = increment; i < diff; i++) {
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
      neededNum = Random().nextInt(maxValue) + minValue;

      fillLists();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (addedNums.isEmpty) {
      neededNum = Random().nextInt(maxValue) + minValue;
      fillLists();
    }

    return (isPlaying)
        ? ListView(
            children: <Widget>[
              Question('GET TO $neededNum', 30),
              ...addedNums.map((n) {
                return NumButton('+' + n.toString(), addNum, n, Colors.blue);
              }).toList(),
              ...subtractedNums.map((n) {
                return NumButton(
                    '-' + n.toString(), subtractNum, n, Colors.red);
              }).toList(),
              SumText('CURRENT SUM: $sum'),
              SumText('STEPS TAKEN: $steps'),
              Container(margin: EdgeInsets.all(10)),
              Ink(
                decoration: const ShapeDecoration(
                  color: Colors.lightBlue,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  icon: const Icon(Icons.home),
                  color: Colors.white,
                  onPressed: returnFunction,
                ),
              )
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
