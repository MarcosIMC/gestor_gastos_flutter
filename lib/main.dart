import 'package:flutter/material.dart';
import 'package:gestion_gastos/providers/transaction_provider.dart';
import 'package:gestion_gastos/screens/summary_screen.dart';
import 'package:gestion_gastos/theme/app_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => TransactionProvider())
    ],
    child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestor de gastos',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: SummaryScreen(),
    );
  }
}