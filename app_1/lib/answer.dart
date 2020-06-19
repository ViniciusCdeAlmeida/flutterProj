import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final Function ans;
  final String resp;
  Answer(this.ans, this.resp);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
          color: Colors.indigo[300],
          textColor: Colors.lime,
          child: Text(resp),
          onPressed: ans),
    );
  }
}
