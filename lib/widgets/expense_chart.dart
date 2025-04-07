import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gestion_gastos/models/transaction.dart';
import 'package:gestion_gastos/providers/transaction_provider.dart';
import 'package:provider/provider.dart';

class ExpenseChart extends StatelessWidget {
  const ExpenseChart({super.key});

  @override
  Widget build(BuildContext context) {

    final transactionProvider = Provider.of<TransactionProvider>(context);
    final transactions = transactionProvider.transactions;
    
    final expenses = transactionsFilteredBy(transactions, TransactionType.EXPENSE);
    final Map<String, double> categoryTotal = {};

    for (var expense in expenses) {
      categoryTotal[expense.category.name] = (categoryTotal[expense.category.name] ?? 0) + expense.amount;
    }

    List<BarChartGroupData> barGroups = categoryTotal.entries.map((entry) {
      int index = categoryTotal.keys.toList().indexOf(entry.key);
      String category = entry.key;
      double amount = entry.value;

      return BarChartGroupData(x: index,
      barRods: [
        BarChartRodData(
          toY: amount,
          color: Colors.blue,
          width: 22,
          borderRadius: BorderRadius.zero,
        ),
      ]);
    }).toList();

    return Container(
      padding: const EdgeInsets.all(16),
      height: 300,
      child: BarChart(
        BarChartData(
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (double value, TitleMeta meta) {
                  int index = value.toInt();
                  String category = categoryTotal.keys.toList()[index];
                  return Padding(padding: EdgeInsets.only(top: 8),
                    child: Text(category, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)
                      ,)
                    ,);
                },
              ),
            ),
          ),
          borderData: FlBorderData(
            border: const Border(
              top: BorderSide.none,
              left: BorderSide.none,
              right: BorderSide.none,
              bottom: BorderSide.none
            )
          ),
          groupsSpace: 10,
          barGroups: barGroups
        ),
      ),
    );
  }

  Iterable<Transaction> transactionsFilteredBy(List<Transaction> transactions, TransactionType type) => transactions.where((transaction) => transaction.transaction == type).toList();
}
