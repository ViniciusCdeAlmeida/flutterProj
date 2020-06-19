import 'package:flutter/material.dart';

import 'result.dart';
import 'quiz.dart';
// void main() {
//   runApp(MyApp());
// }

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _questIdx = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questIdx = 0;
      _totalScore = 0;
    });
  }

  final _quests = const [
    {
      'text': '1 question',
      'ans': [
        {'text': 'red', 'score': 1},
        {'text': 'green', 'score': 3},
        {'text': 'blue', 'score': 2},
        {'text': 'white', 'score': 4}
      ]
    },
    {
      'text': '2 question',
      'ans': [
        {'text': '7', 'score': 4},
        {'text': '2', 'score': 3},
        {'text': '4', 'score': 1},
        {'text': '2', 'score': 2}
      ]
    },
    {
      'text': '3 question',
      'ans': [
        {'text': 'A', 'score': 3},
        {'text': 'N', 'score': 4},
        {'text': 'W', 'score': 2},
        {'text': 'K', 'score': 1}
      ]
    }
  ];

  void _ansQuest(int score) {
    _totalScore += score;
    if (_questIdx < _quests.length) {
      setState(() {
        _questIdx = _questIdx + 1;
      });
      print('ans');
    }
  }

  Widget build(BuildContext ctx) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('1 APP'),
          ),
          body: _questIdx < _quests.length
              ? Quiz(
                  ans: _ansQuest,
                  quests: _quests,
                  questIdx: _questIdx,
                )
              : Result(_totalScore,_resetQuiz)),
    );
  }
}
