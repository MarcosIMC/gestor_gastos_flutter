import 'package:flutter/material.dart';
import 'package:gestion_gastos/screens/transaction_form_screen.dart';
import 'package:gestion_gastos/screens/transaction_history_screen.dart';
import 'package:gestion_gastos/widgets/expense_chart.dart';
import 'package:gestion_gastos/widgets/money_card.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Resumen Gastos"),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (expenseData) => const TransactionHistoryScreen()
            ));
          },
              icon: Icon(Icons.history))
        ],
      ),
      body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  'Resumen del mes',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 20,),
              const MoneyCard(title: 'Ingresos', color: Colors.green, arrowIcon: Icons.arrow_downward_outlined,),
              const SizedBox(height: 20,),
              const MoneyCard(title: 'Gastos', color: Colors.red, arrowIcon: Icons.arrow_upward_outlined,),
              const SizedBox(height: 20,),
              ExpenseChart(),
              const SizedBox(height: 20,),
              Center(
                child: ElevatedButton.icon(
                  icon: Icon(Icons.add, color: Colors.white,),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) => TransactionFormScreen())
                      );
                    },
                    label: const Text('Hacer transacción', style:
                      TextStyle(color: Colors.white),),
                ),
              )
            ],
          ),
      ),
    );
  }
}
