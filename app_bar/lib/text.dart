import 'package:flutter/material.dart';

import 'package:app_bar/question.dart';
import 'package:app_bar/answer.dart';

class TextCl extends StatelessWidget {
  final List<Map<String, Object>> quests;
  final Function ans;
  final int idx;

  TextCl({@required this.quests, @required this.ans, @required this.idx});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(quests[idx]['text']),
        ...(quests[idx]['ans'] as List<Map<String, Object>>).map((e) {
          return Answer(() => ans(), e['text']);
        }).toList()
      ],
    );
  }
}
