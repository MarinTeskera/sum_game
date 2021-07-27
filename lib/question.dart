import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String questionText;
  final double size;

  Question(this.questionText, this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.all(10),
        child: Text(
          questionText,
          style: TextStyle(fontSize: size),
          textAlign: TextAlign.center,
        ));
  }
}
