import 'package:gestion_gastos/models/categories.dart';

enum TransactionType {
    INCOME,
    EXPENSE
}

class Transaction {
  final String id;
  late double amount;
  late Category category;
  late String description;
  late TransactionType transaction;
  final DateTime date;

  Transaction({required this.id, required this.amount, required this.category, required this.transaction, required this.date, required this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'category': category.name,
      'description': description,
      'type': transaction == TransactionType.INCOME ? 'incomde' : 'expense',
      'date': date.toIso8601String()
    };
  }
}