import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int qtd;
  final double price;

  CartItem({
    @required this.id,
    @required this.price,
    @required this.qtd,
    @required this.title,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cart) {
      total += cart.price * cart.qtd;
    });
    return total;
  }

  void addItem(
    String productId,
    double price,
    String title,
  ) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (exist) => CartItem(
                id: exist.id,
                price: exist.price,
                qtd: exist.qtd + 1,
                title: exist.title,
              ));
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          price: price,
          qtd: 1,
          title: title,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_items.containsKey(id)) {
      return;
    }
    if (_items[id].qtd > 1) {
      _items.update(
        id,
        (value) => CartItem(
          id: value.id,
          price: value.price,
          qtd: value.qtd - 1,
          title: value.title,
        ),
      );
    } else {
      _items.remove(id);
    }
    notifyListeners();
  }

  void clearCart() {
    _items = {};
    notifyListeners();
  }
}
