import 'package:flutter/material.dart';

import 'question.dart';
import 'answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> quests;
  final Function ans;
  final int questIdx;

  Quiz({@required this.quests, @required this.ans, @required this.questIdx});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(quests[questIdx]['text']),
        ...(quests[questIdx]['ans'] as List<Map<String, Object>>).map((quest) {
          return Answer(() => ans(quest['score']), quest['text']);
        }).toList()
      ],
    );
  }
}
