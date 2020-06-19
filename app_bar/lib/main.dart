import 'dart:math';
import 'package:flutter/material.dart';

import 'package:app_bar/text.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _rand = new Random();

  var _questIdx = 0;
  final _quests = const [
    {
      'text': '1',
      'ans': [
        {'text': 'Asus'}
      ]
    },
    {
      'text': '2',
      'ans': [
        {'text': 'Samsung'}
      ]
    },
    {
      'text': '3',
      'ans': [
        {'text': 'LG'}
      ]
    },
    {
      'text': '4',
      'ans': [
        {'text': 'Nivea'}
      ]
    },
    {
      'text': '5',
      'ans': [
        {'text': 'Device'}
      ]
    },
    {
      'text': '6',
      'ans': [
        {'text': 'Flutter'}
      ]
    },
  ];
  
  void _ansQuest() {
    setState(() {
      _questIdx = _rand.nextInt(5);
    });
  }

  Widget build(BuildContext ctx) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('APP')),
            body: TextCl(
              quests: _quests,
              ans: _ansQuest,
              idx: _questIdx,
            )));
  }
}
