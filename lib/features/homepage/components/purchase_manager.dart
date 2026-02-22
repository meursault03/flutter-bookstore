import 'package:flutter/material.dart';
import 'mock_data.dart';

class Purchase {
  final Book book;
  final int quantity;
  final DateTime date;

  const Purchase({
    required this.book,
    required this.quantity,
    required this.date,
  });

  double get total => book.price * quantity;
}

class PurchaseManager {
  static final PurchaseManager _instance = PurchaseManager._internal();
  factory PurchaseManager() => _instance;
  PurchaseManager._internal();

  final ValueNotifier<List<Purchase>> history = ValueNotifier([]);

  void registrarCompra(Book book, {int quantity = 1}) {
    history.value = [
      Purchase(book: book, quantity: quantity, date: DateTime.now()),
      ...history.value,
    ];
  }

  void limpar() {
    history.value = [];
  }
}
