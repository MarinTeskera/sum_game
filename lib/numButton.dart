import 'package:flutter/material.dart';

class NumButton extends StatelessWidget {
  final String text;
  final Function fn;
  final int n;
  var color;

  NumButton(this.text, this.fn, this.n, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: fn(n),
        child: Text(
          text,
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        ),
        style: ElevatedButton.styleFrom(primary: color),
      ),
      margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
    );
  }
}
