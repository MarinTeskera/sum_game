import 'package:flutter/material.dart';

class SumText extends StatelessWidget {
  var text;

  SumText(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
