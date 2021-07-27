import 'package:flutter/material.dart';

class ResetButton extends StatelessWidget {
  final Function fn;
  var text;

  ResetButton(this.text, this.fn);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.fromLTRB(30, 30, 30, 10),
      child: ElevatedButton(
        child: Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
        onPressed: fn(),
        style: ElevatedButton.styleFrom(primary: Colors.green),
      ),
    );
  }
}
