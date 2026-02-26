import 'dart:convert';
import 'package:flutter/services.dart';

/// Modelo de dados de um livro. Contém título, autor, preço, descrição, imagem, categoria e estoque. Suporta `fromJson()`.
class Book {
  final int id;
  final String authorName;
  final double price;
  final String title;
  final String description;
  final String image;
  final String categoria;
  final int estoque;

  const Book({
    required this.id,
    required this.authorName,
    required this.price,
    required this.title,
    required this.description,
    required this.image,
    required this.categoria,
    required this.estoque,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'].toInt() as int,
      authorName: json['authorName'] as String,
      price: json['price'].toDouble() as double,
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      categoria: json['categoria'] as String,
      estoque: json['estoque'].toInt() as int,
    );
  }
}

/// Retorna as categorias únicas na ordem de aparição na lista.
List<String> extractCategories(List<Book> books) {
  final seen = <String>{};
  final categories = <String>[];
  for (final book in books) {
    if (seen.add(book.categoria)) {
      categories.add(book.categoria);
    }
  }
  return categories;
}

Future<List<Book>> loadBooks() async {
  final jsonString = await rootBundle.loadString('assets/data/books.json');
  final List<dynamic> decodedList = json.decode(jsonString) as List<dynamic>;
  return decodedList
      .map((json) => Book.fromJson(json as Map<String, dynamic>))
      .toList();
}

Future<Map<int, Book>> loadBooksAsMap() async {
  List<Book> books = await loadBooks();
  return {for (var book in books) book.id: book};
}
