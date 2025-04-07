import 'package:flutter/cupertino.dart';
import 'package:gestion_gastos/models/transaction.dart';
import 'package:gestion_gastos/service/database_helper.dart';

class TransactionProvider with ChangeNotifier {
  late List<Transaction> _transactions = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  List<Transaction> get transactions => _transactions;

  void add(Transaction transaction) async {
    _transactions.add(transaction);
    await _dbHelper.insertTransaction(transaction);
    notifyListeners();
  }

  void delete(String id) async {
    _transactions.removeWhere((transaction) => transaction.id == id);
    await _dbHelper.deleteTransaction(id);
    notifyListeners();
  }

  void update(Transaction transaction) async {
    int index = _transactions.indexWhere((transaction) => transaction.id == transaction.id);
    _transactions[index] = transaction;
    await _dbHelper.updateTransaction(transaction);
    notifyListeners();
  }

  Future<void> loadTransactions() async {
    _transactions = await _dbHelper.getTransactions();
    notifyListeners();
  }
}