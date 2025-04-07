import 'package:flutter_test/flutter_test.dart';
import 'package:gestion_gastos/models/categories.dart';
import 'package:gestion_gastos/models/transaction.dart';
import 'package:gestion_gastos/providers/transaction_provider.dart';

void main() {
  late TransactionProvider provider;

  setUpAll(() {
    provider = TransactionProvider();
  });
  group('Transaction provider should', () {
    test('Return empty transaction when we not add any transaction', () {
      expect(provider.transactions.isEmpty, equals(isTrue));
    });

    test('Add new transaction', () {
      provider.add(Transaction('1', 130, Category.OCIO, TransactionType.INCOME, DateTime.now(), 'Prueba'));
      expect(provider.transactions.isEmpty, equals(isFalse));
      expect(provider.transactions.length, equals(1));
    });

    test('Check if can access to transaction data', () {
      var transaction = provider.transactions.first;
      expect(transaction.category, equals(Category.OCIO));
      expect(transaction.amount, equals(130));
      expect(transaction.transaction, equals(TransactionType.INCOME));
    });

    test('Delete a transaction', () {
      provider.delete(provider.transactions.first.id.toString());
      expect(provider.transactions.length, equals(0));
    });
  });
}