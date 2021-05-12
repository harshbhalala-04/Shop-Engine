import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isfavorite;

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isfavorite = false});

  // void _setFavValue(bool newValue) {
  //   isfavorite = newValue;
  //   notifyListeners();
  // }

  Future<void> toggleFavouriteStatus(String token, String userId) async {
    final oldStatus = isfavorite;
    isfavorite = !isfavorite;
    notifyListeners();
    var url =
        'https://shop-app-a687f-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token';
    try {
      final response = await http.put(
        url,
        body: json.encode(
           isfavorite,
        ),
      );
      if (response.statusCode >= 400) {
        isfavorite = oldStatus;
        notifyListeners();
      }
    } catch (error) {
      isfavorite = oldStatus;
      notifyListeners();
    }
  }
}
