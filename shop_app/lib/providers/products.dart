import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  var _showFavoritiesOnly = false;

  final String authToken;
  final String usrId;

  Products(this.authToken, this._items, this.usrId);

  List<Product> get items {
    if (_showFavoritiesOnly) {
      return _items.where((element) => element.isFavorite).toList();
    }
    return [..._items];
  }

  List<Product> get favItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> getProduct([bool filterUser = false]) async {
    final filterString =
        filterUser ? 'orderBy="creatorId"&equalTo="$usrId"' : '';
    final url =
        'https://flutter-shop-app-72a96.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final extData = json.decode((response.body)) as Map<String, dynamic>;
      final List<Product> loadedProd = [];
      if (extData == null) {
        return;
      }
      final favoriteResponseUrl =
          'https://flutter-shop-app-72a96.firebaseio.com/usrFav/$usrId.json?auth=$authToken';
      final favoriteResponse = await http.get(favoriteResponseUrl);
      final favoriteData = json.decode(favoriteResponse.body);
      extData.forEach((prodId, prodData) {
        loadedProd.add(Product(
          id: prodId,
          description: prodData['description'],
          title: prodData['title'],
          price: prodData['price'],
          imgUrl: prodData['imgUrl'],
          isFavorite:
              favoriteData == null ? false : favoriteData[prodId] ?? false,
        ));
      });
      _items = loadedProd;
      notifyListeners();
    } catch (error) {}
    // throw (error){};
  }

  Future<void> addProduct(Product product) async {
    final url =
        'https://flutter-shop-app-72a96.firebaseio.com/products.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imgUrl': product.imgUrl,
          'price': product.price,
          'creatorId': usrId,
        }),
      );
      final newProduct = Product(
        description: product.description,
        id: json.decode(response.body)['name'],
        imgUrl: product.imgUrl,
        price: product.price,
        title: product.title,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIdx = _items.indexWhere((element) => element.id == id);
    if (prodIdx >= 0) {
      final url =
          'https://flutter-shop-app-72a96.firebaseio.com/products/$id.json?auth=$authToken';
      await http.patch(
        url,
        body: json.encode({
          'title': newProduct.title,
          'description': newProduct.description,
          'imgUrl': newProduct.imgUrl,
          'price': newProduct.price,
        }),
      );
      _items[prodIdx] = newProduct;
      notifyListeners();
    }
  }

  void deleteProducts(String id) {
    final url =
        'https://flutter-shop-app-72a96.firebaseio.com/products/$id.json?auth=$authToken';
    final existingProdIdx = _items.indexWhere((element) => element.id == id);
    var existingProd = _items[existingProdIdx];
    http.delete(url).then((_) {
      existingProd = null;
    }).catchError((_) {
      _items.insert(existingProdIdx, existingProd);
    });
    _items.removeAt(existingProdIdx);
    notifyListeners();
  }
}
