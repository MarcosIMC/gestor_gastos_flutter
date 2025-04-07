import 'package:gestion_gastos/models/categories.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:gestion_gastos/models/transaction.dart' as my_transaction;

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'transactions.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE transactions ('
        'id TEXT PRIMARY KEY,'
        'category TEXT,'
        'amount REAL,'
        'description TEXT,'
        'type TEXT,'
        'date TEXT)');
  }

  Future<void> insertTransaction(my_transaction.Transaction transaction) async {
    final db = await database;
    await db.insert(
      'transactions',
      transaction.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<my_transaction.Transaction>> getTransactions() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('transactions');
    return List.generate(maps.length, (i) {
      return my_transaction.Transaction(
        id: maps[i]['id'],
        amount: maps[i]['amount'],
        category: maps[i]['category'],
        transaction: maps[i]['transaction'] == 'income' ? my_transaction.TransactionType.INCOME : my_transaction.TransactionType.EXPENSE,
        date: DateTime.parse(maps[i]['date']),
        description: maps[i]['description']
      );
    });
  }

  Future<void> deleteTransaction(String id) async {
    final db = await database;
    await db.delete(
      'transactions',
      where: 'id = ?',
      whereArgs: [id]
    );
  }

  Future<void> updateTransaction(my_transaction.Transaction transaction) async {
    final db = await database;
    await db.update('transactions',
      transaction.toMap(),
      where: 'id = ?',
      whereArgs: [transaction.id]
    );
  }
}