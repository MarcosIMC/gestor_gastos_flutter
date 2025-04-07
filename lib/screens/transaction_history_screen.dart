import 'package:flutter/material.dart';
import 'package:gestion_gastos/models/transaction.dart';
import 'package:gestion_gastos/providers/transaction_provider.dart';
import 'package:gestion_gastos/screens/transaction_form_screen.dart';
import 'package:gestion_gastos/widgets/delete_confirm_dialog.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    final transactions = transactionProvider.transactions;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de transacciones'),
        centerTitle: true,
      ),
      body: transactions.isEmpty ? const Center(
        child: Text('No hay transacciones registradas'),
      ): ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final transaction = transactions[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: ListTile(
                leading: Icon(
                  transaction.transaction == TransactionType.EXPENSE
                      ? Icons.arrow_upward_outlined
                      : Icons.arrow_downward_outlined,
                      color: transaction.transaction == TransactionType.INCOME
                    ? Colors.green
                          : Colors.red
                ),
                title: Text(transaction.category.name),
                subtitle: Text(
                  DateFormat.yMMMd().format(transaction.date)
                ),
                trailing: Text(
                  '${transaction.amount.toStringAsFixed(2) }€',
                  style: TextStyle(
                    color: transaction.transaction == TransactionType.INCOME
                        ? Colors.green
                        : Colors.red,
                        fontWeight: FontWeight.bold
                  ),
                ),
                onLongPress: () {
                  showDialog(context: context, builder: (BuildContext context) {
                    return DeleteConfirmDialog(provider: transactionProvider, transactionId: transaction.id,);
                  });
                },
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionFormScreen(transaction: transaction,)));
                },
              ),
            );
          }
      ),
    );
  }
}
