import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imgUrl;
  bool isFavorite;

  Product({
    @required this.description,
    @required this.id,
    @required this.imgUrl,
    this.isFavorite = false,
    @required this.price,
    @required this.title,
  });

  void _checkStatus(bool status) {
    isFavorite = status;
    notifyListeners();
  }

  Future<void> toggleFav(String authToken, String usrId) async {
    final url =
        'https://flutter-shop-app-72a96.firebaseio.com/usrFav/$usrId/$id.json?auth=$authToken';
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      final response = await http.put(
        url,
        body: json.encode(
          isFavorite,
        ),
      );
      if (response.statusCode >= 400) {
        _checkStatus(oldStatus);
      }
    } catch (aaa) {
      _checkStatus(oldStatus);
    }
  }
}
