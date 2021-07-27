import 'package:flutter/material.dart';

class ResetButton extends StatelessWidget {
  var fn;
  final String text;

  ResetButton(this.fn, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(70),
      child: ElevatedButton(
        onPressed: fn,
        child: Text(text),
        style: ElevatedButton.styleFrom(primary: Colors.green),
      ),
    );
  }
}
