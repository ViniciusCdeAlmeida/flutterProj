import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime datetime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.datetime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String authToken;
  final String userId;

  Orders(this.authToken,this._orders,this.userId);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> getOrder() async {
    final url = 'https://flutter-shop-app-72a96.firebaseio.com/orders/$userId.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final extData = json.decode((response.body)) as Map<String, dynamic>;
      final List<OrderItem> loadedOrder = [];
      if(extData == null) {
        return;
      }
      extData.forEach((orderId, orderData) {
        loadedOrder.add(
          OrderItem(
            id: orderId,
            amount: orderData['amount'],
            datetime: DateTime.parse(orderData['datetime']),
            products: (orderData['products'] as List<dynamic>)
                .map(
                  (item) => CartItem(
                    id: item['id'],
                    price: item['price'],
                    qtd: item['qtd'],
                    title: item['title'],
                  ),
                )
                .toList(),
          ),
        );
      });
      print(loadedOrder);
      _orders = loadedOrder;
      notifyListeners();
    } catch (error) {}
    // throw (error){};
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    final url = 'https://flutter-shop-app-72a96.firebaseio.com/orders/$userId.json?auth=$authToken';
    final _timeStamp = DateTime.now();

    try {
      final response = await http
          .post(
        url,
        body: json.encode({
          'amount': total,
          'products': cartProducts
              .map((cp) => {
                    'id': cp.id,
                    'price': cp.price,
                    'qtd': cp.qtd,
                    'title': cp.title,
                  })
              .toList(),
          'datetime': _timeStamp.toIso8601String(),
        }),
      )
          .then((resp) {
        _orders.insert(
          0,
          OrderItem(
            id: json.decode(resp.body)['name'],
            amount: total,
            products: cartProducts,
            datetime: _timeStamp,
          ),
        );
        notifyListeners();
      });
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
