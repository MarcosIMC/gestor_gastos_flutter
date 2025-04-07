import 'package:flutter/material.dart';
import 'package:gestion_gastos/models/transaction.dart';
import 'package:gestion_gastos/providers/transaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/categories.dart';

class TransactionFormScreen extends StatefulWidget {
  final Transaction? transaction;
  const TransactionFormScreen({super.key, this.transaction});

  @override
  State<TransactionFormScreen> createState() => _TransactionFormScreenState();
}

class _TransactionFormScreenState extends State<TransactionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late Category _selectedCategory = Category.OCIO;
  late TransactionType _selectedType = TransactionType.EXPENSE;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrar Transacción'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: 'Cantidad'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserta una cantidad';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20,),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Inserta una descripción';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20,),
              DropdownButtonFormField(
                value: _selectedCategory,
                  decoration: const InputDecoration(
                    labelText: 'Categoría'
                  ),
                  items: Category.values.map((Category category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category.name),
                    );
                  }).toList(),
                  onChanged: (Category? value) {
                    _selectedCategory = value!;
                  },
                validator: (value) {
                  if (value == null) {
                    _selectedCategory = Category.OCIO;
                  }
                },
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: RadioListTile(
                      title: Text('Gasto'),
                        value: TransactionType.EXPENSE,
                        groupValue: _selectedType,
                        onChanged: (TransactionType ? value) {
                          setState(() {
                            _selectedType = value!;
                          });
                        }),
                  ),
                  Expanded(
                    child: RadioListTile(
                        title: Text('Ingreso'),
                        value: TransactionType.INCOME,
                        groupValue: _selectedType,
                        onChanged: (TransactionType ? value) {
                          setState(() {
                            _selectedType = value!;
                          });
                        }),
                  )
                ],
              ),
              const SizedBox(height: 20,),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final transactionProvider = Provider.of<TransactionProvider>(context, listen: false);
                        if(widget.transaction == null) {
                          final newTransaction = Transaction(
                              id: Uuid().v4(), amount: double.parse(_amountController.text), category: _selectedCategory, transaction: _selectedType, date: DateTime.now(), description: _descriptionController.text
                          );
                          transactionProvider.add(newTransaction);
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Transacción registrada.'))
                          );
                        } else {
                          widget.transaction!.category = _selectedCategory;
                          widget.transaction!.amount = double.parse(_amountController.text);
                          widget.transaction!.description = _descriptionController.text;
                          widget.transaction!.transaction = _selectedType;
                        }
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            widget.transaction == null
                                ? 'Transacción registrada'
                                : 'Transacción actualizada'
                          ),
                        ));
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                    widget.transaction == null
                      ? 'Guardar transacción'
                      : 'Actualizar transacción',
                    style: const TextStyle(
                      color: Colors.white
                    ),)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
