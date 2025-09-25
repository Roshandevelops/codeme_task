import 'dart:convert';

import 'package:codeme_task/domain/model/product_model.dart';
import 'package:codeme_task/domain/repository/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends ChangeNotifier {
  List<ProductModel> products = [];
  List<ProductModel> filteredProducts = [];
  bool isLoading = false;

  final List<CartItem> cart = [];

  Future<void> loadProducts() async {
    isLoading = true;
    notifyListeners();

    try {
      products = await ProductRepository.fetchProducts();
      filteredProducts = products;
    } catch (e) {
      products = [];
      filteredProducts = [];
    }

    isLoading = false;
    notifyListeners();
  }

  void filterProducts(String query) {
    if (query.isEmpty) {
      filteredProducts = products;
    } else {
      filteredProducts = products
          .where((p) =>
              (p.title ?? "").toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  // -------------------- CART METHODS --------------------

  Future<void> loadCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartString = prefs.getString('cart') ?? '[]';
    final List decoded = json.decode(cartString);

    cart.clear();
    for (var item in decoded) {
      cart.add(CartItem.fromJson(item));
    }
    notifyListeners();
  }

  Future<void> saveCart() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = cart.map((e) => e.toJson()).toList();
    prefs.setString('cart', json.encode(cartJson));
  }

  void addToCart(ProductModel product) {
    final existing = cart.indexWhere((item) => item.product.id == product.id);
    if (existing >= 0) {
      cart[existing].quantity += 1;
    } else {
      cart.add(CartItem(product: product, quantity: 1));
    }
    saveCart();
    notifyListeners();
  }

  void removeFromCart(ProductModel product) {
    cart.removeWhere((item) => item.product.id == product.id);
    saveCart();
    notifyListeners();
  }

  void increaseQuantity(CartItem item) {
    item.quantity += 1;
    saveCart();
    notifyListeners();
  }

  void decreaseQuantity(CartItem item) {
    if (item.quantity > 1) {
      item.quantity -= 1;
      saveCart();
      notifyListeners();
    }
  }

  double get totalPrice {
    double total = 0;
    for (var item in cart) {
      total += (item.product.price ?? 0) * item.quantity;
    }
    return total;
  }
}

class CartItem {
  final ProductModel product;
  int quantity;

  CartItem({required this.product, required this.quantity});

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      product: ProductModel.fromJson(json['product']),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product': product.toJson(),
      'quantity': quantity,
    };
  }
}
