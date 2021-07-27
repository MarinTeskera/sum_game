import 'dart:math';

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
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  Random generator = Random();

  int sum = 0;
  int neededNum = 100;
  int steps = 0;

  List addedNums = [2, 3, 6];
  List subtractedNums = [1, 4, 9];

  String resetText = 'RESET';

  Function addNum(int n) {
    return () => setState(() {
          steps++;
          sum += n;
          if (sum == neededNum) {
            resetText = 'WELL DONE!';
          }
        });
  }

  Function subtractNum(int n) {
    return () => setState(() {
          steps++;
          sum -= n;
          if (sum == neededNum) {
            resetText = 'WELL DONE!';
          }
        });
  }

  Function resetSum() {
    return () => setState(() {
          steps = 0;
          if (sum == neededNum) {
            if (generator.nextInt(2) > 0) {
              neededNum = generator.nextInt(150);
            } else {
              neededNum = generator.nextInt(100) * -1;
            }
            resetText = 'RESET';
          }
          sum = 0;

          for (var i = 0; i < 3; i++) {
            var add = generator.nextInt(10) + 1;
            var sub = generator.nextInt(10) + 1;
            setState(() {
              while (addedNums.contains(add)) {
                add = generator.nextInt(10) + 1;
              }
              addedNums[i] = add;
            });
            setState(() {
              while (subtractedNums.contains(sub)) {
                sub = generator.nextInt(10) + 1;
              }
              subtractedNums[i] = sub;
            });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    //var questions = ['Question 1', 'Question 2'];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: Column(
          children: <Widget>[
            Question('GET TO $neededNum'),
            ...addedNums.map((n) {
              return NumButton('+' + n.toString(), addNum, n, Colors.blue);
            }).toList(),
            ...subtractedNums.map((n) {
              return NumButton('-' + n.toString(), subtractNum, n, Colors.red);
            }).toList(),
            ResetButton(resetText, resetSum),
            SumText('CURRENT SUM: $sum'),
            Text(
              'STEPS TAKEN: $steps',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
