import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/db_helper.dart';
import '../models/expense_models.dart';

// State ketika data sedang dimuat
class ExpenseLoading extends ExpenseState {}

// State dasar untuk Expense
class ExpenseState {
  final List<Expense> expenses;
  final int dailyTotal;
  final int monthlyTotal;
  final int yesterdayTotal;
  final Map<String, int> categoryTotals;

  ExpenseState({
    this.expenses = const [],
    this.dailyTotal = 0,
    this.monthlyTotal = 0,
    this.yesterdayTotal = 0,
    this.categoryTotals = const {},
  });
}

// State ketika data sudah dimuat
class ExpenseLoaded extends ExpenseState {
  final List<Expense> dailyExpenses;
  final List<Expense> yesterdayExpenses;
  final List<Expense> monthlyExpenses;
  final int dailyTotal;
  final int yesterdayTotal;
  final int monthlyTotal;
  final Map<String, int> categoryTotals;

  ExpenseLoaded(
      this.dailyExpenses,
      this.yesterdayExpenses,
      this.monthlyExpenses,
      this.dailyTotal,
      this.yesterdayTotal,
      this.monthlyTotal,
      this.categoryTotals,
      ) : super(
    // dailyTotal: dailyTotal,
    // yesterdayTotal: yesterdayTotal,
    // monthlyTotal: monthlyTotal,
    // categoryTotals: categoryTotals,
  );
}

class ExpenseCubit extends Cubit<ExpenseState> {
  final DatabaseHelper databaseHelper;

  ExpenseCubit(this.databaseHelper) : super(ExpenseLoading());

  Future<void> loadExpenses() async {
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final dailyExpenses = await databaseHelper.getExpensesByDate(now);
    final yesterdayExpenses = await databaseHelper.getExpensesByDate(yesterday);
    final monthlyExpenses = await databaseHelper.getExpensesForMonth(now);
    final dailyTotal = await databaseHelper.getDailyTotal();
    final yesterdayTotal = await databaseHelper.getYesterdayTotal();
    final monthlyTotal = await databaseHelper.getMonthlyTotal();
    final categoryTotals = await databaseHelper.getTotalExpenseByCategory();

    emit(ExpenseLoaded(
      dailyExpenses,
      yesterdayExpenses,
      monthlyExpenses,
      dailyTotal,
      yesterdayTotal,
      monthlyTotal,
      categoryTotals,
    ));
  }

  Future<void> addExpense(Expense expense) async {
    await databaseHelper.insertExpense(expense);
    await loadExpenses();
  }
}