import 'package:flutter/foundation.dart';

class Transact {
  final String id;
  final String title;
  final double money;
  final DateTime date;

  Transact({@required this.id, @required this.title, @required this.money, @required this.date});
}