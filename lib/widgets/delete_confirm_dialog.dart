import 'package:flutter/material.dart';
import 'package:gestion_gastos/providers/transaction_provider.dart';
import 'package:gestion_gastos/widgets/snackbar_delete.dart';

class DeleteConfirmDialog extends StatelessWidget {
  final TransactionProvider provider;
  final String transactionId;
  final snackBar = SnackBar(content: const Text('Tarea eliminada'));

  DeleteConfirmDialog({super.key, required this.provider, required this.transactionId});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      title: const Text('Eliminar',
      style: TextStyle(
        fontWeight: FontWeight.bold
      ),
      ),
      content: const Text('¿Seguro que quiere eliminar la transacción?'),
      actions: [
        ElevatedButton(onPressed: () {
          Navigator.of(context).pop();
        },
            child: const Text('Cancelar')
        ),
        ElevatedButton(onPressed: () {
          provider.delete(transactionId);
          Navigator.of(context).pop();
          SnackbarDelete.showSnackbar(context);
        },
            child: const Text('Eliminar',
            style: TextStyle(color: Colors.red),
            )
        ),
      ],
    );
  }
}
