import 'package:flutter/material.dart';

class DifficultyButton extends StatelessWidget {
  var fn;
  var text;

  DifficultyButton(this.fn, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(5),
      child: ElevatedButton(
        onPressed: fn,
        child: Text(text),
      ),
    );
  }
}
