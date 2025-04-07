import 'package:flutter/material.dart';
import 'package:gestion_gastos/models/transaction.dart';
import 'package:provider/provider.dart';

import '../providers/transaction_provider.dart';

class MoneyCard extends StatelessWidget {
  final String title;
  final Color color;
  final IconData arrowIcon;

  const MoneyCard({super.key, required this.title, required this.color, required this.arrowIcon});

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final transactions = transactionProvider.transactions;


    return Card(
      child: ListTile(
        leading: Icon(arrowIcon, color: color),
        title: Text(title),
        subtitle: Text('${color == Colors.green
            ? totalMoney(transactions, TransactionType.INCOME)
            : totalMoney(transactions, TransactionType.EXPENSE)}'
            '€'),
      ),
    );
  }

  double totalMoney(List<Transaction> transactions, TransactionType type) {
    return transactions.where((transaction) => transaction.transaction == type)
  .fold(0.0, (sum, transaction) => sum + transaction.amount);
  }
}
