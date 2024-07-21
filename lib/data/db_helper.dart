import 'package:moneyexp/models/expense_models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'expenses.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE expenses(id INTEGER PRIMARY KEY, category TEXT, description TEXT, amount INTEGER, date TEXT)',
        );
      },
    );
  }

  Future<void> insertExpense(Expense expense) async {
    final db = await database;
    await db.insert('expenses', expense.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Expense>> getExpenses() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('expenses');
    return List.generate(maps.length, (i) {
      return Expense.fromMap(maps[i]);
    });
  }

  Future<int> getDailyTotal() async {
    final db = await database;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day).toIso8601String().split('T').first;
    final result = await db.rawQuery(
        'SELECT SUM(amount) as dailyTotal FROM expenses WHERE date(date) = ? ORDER BY date DESC',
        [today]
    );
    return result[0]['dailyTotal'] != null ? (result[0]['dailyTotal'] as int) : 0;
  }

  Future<int> getYesterdayTotal() async {
    final db = await database;
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1).toIso8601String().split('T').first;
    final result = await db.rawQuery(
        'SELECT SUM(amount) as yesterdayTotal FROM expenses WHERE date(date) = ?',
        [yesterday]
    );
    return result[0]['yesterdayTotal'] != null ? (result[0]['yesterdayTotal'] as int) : 0;
  }

  Future<int> getMonthlyTotal() async {
    final db = await database;
    final now = DateTime.now();
    final monthStart = DateTime(now.year, now.month, 1).toIso8601String().split('T').first;
    final result = await db.rawQuery(
        'SELECT SUM(amount) as monthlyTotal FROM expenses WHERE date(date) >= ?',
        [monthStart]
    );
    print(result);
    return result[0]['monthlyTotal'] != null ? (result[0]['monthlyTotal'] as int) : 0;
  }

  Future<List<Expense>> getExpensesByDate(DateTime date) async {
    final db = await database;
    final dateString = date.toIso8601String().split('T').first;
    final List<Map<String, dynamic>> maps = await db.query(
      'expenses',
      where: 'date(date) = ?',
      whereArgs: [dateString],
      orderBy: 'date DESC',
    );
    print(maps);
    return List.generate(maps.length, (i) {
      return Expense.fromMap(maps[i]);
    });
  }

  Future<List<Expense>> getExpensesForMonth(DateTime date) async {
    final db = await database;
    final monthStart = DateTime(date.year, date.month, 1).toIso8601String().split('T').first;
    final List<Map<String, dynamic>> maps = await db.query(
      'expenses',
      where: 'date(date) >= ?',
      whereArgs: [monthStart],
      orderBy: 'date DESC',
      limit: 5,
    );
    return List.generate(maps.length, (i) {
      return Expense.fromMap(maps[i]);
    });
  }

  Future<Map<String, int>> getTotalExpenseByCategory() async {
    final db = await database;
    final result = await db.rawQuery(
        'SELECT category, SUM(amount) as total FROM expenses GROUP BY category ORDER BY date DESC');

    Map<String, int> categoryTotals = {};
    for (var row in result) {
      categoryTotals[row['category'] as String] = row['total'] as int;
    }
    return categoryTotals;
  }
}
