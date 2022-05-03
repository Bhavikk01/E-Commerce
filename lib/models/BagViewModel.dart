import 'package:e_commerce/models/products.dart';
import 'package:flutter/cupertino.dart';

class BagViewModel extends ChangeNotifier{
  final List<Product> productsBag;

  BagViewModel(): productsBag=[];
  
  void addProduct(Product item)
  {
    productsBag.add(item);
    notifyListeners();
  }
  void removeProduct(Product item) {
    productsBag.remove(item);
    notifyListeners();
  }
  int get totalProducts => productsBag.length;

  double get totalPrice => productsBag.fold(0, (total, product) {
    return total + product.price;
  });

  void clearBag() {
    productsBag.clear();
    notifyListeners();
  }
  bool get isBagEmpty => productsBag.isEmpty;

}