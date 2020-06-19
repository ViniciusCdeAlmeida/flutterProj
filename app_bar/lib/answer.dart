import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function ans;
  final String res;

  Answer(this.ans, this.res);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        onPressed: ans,
        color: Colors.amber,
        textColor: Colors.blueAccent,
        child: Text(res),
      ),
    );
  }
}
