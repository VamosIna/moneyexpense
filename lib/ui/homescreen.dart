import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moneyexp/models/expense_models.dart';
import 'package:moneyexp/utils/fonts.dart';
import '../cubit/expense_cubit.dart';
import '../utils/colors.dart';
import 'add_expense_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Halo, User!',
              style: FontStyles.bold,
            ),
            Text(
              'Jangan lupa catat keuanganmu setiap hari!',
              style: FontStyles.regular.copyWith(color: AppColors.customColor2,fontSize: 12),
            ),
          ],
        ),
      ),
      body: BlocBuilder<ExpenseCubit, ExpenseState>(
        builder: (context, state) {
          if (state is ExpenseLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ExpenseLoaded) {
            return Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildExpenseSummary(context, 'Pengeluaranmu hari ini', state.dailyTotal),
                          _buildExpenseSummaryMonth(context, 'Pengeluaranmu bulan ini', state.monthlyTotal),
                        ],
                      ),
                      SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Pengeluaran berdasarkan kategori', style: FontStyles.bold),
                      ),
                      SizedBox(height: 16),
                      _buildCategorySummary(context, state.categoryTotals),
                      SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Hari ini', style: FontStyles.bold14),
                      ),
                      _buildExpenseList(context, state.dailyExpenses),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Kemarin', style: FontStyles.bold14),
                      ),
                      _buildExpenseList(context, state.yesterdayExpenses),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Bulan ini', style: FontStyles.bold14),
                      ),
                      _buildExpenseList(context, state.monthlyExpenses),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: FloatingActionButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddExpenseScreen()),
                    ),
                    child: Icon(Icons.add, color: AppColors.backgroundColor),
                    backgroundColor: AppColors.secondaryColor,
                    elevation: 1.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(child: Text('Something went wrong!'));
          }
        },
      ),
    );
  }

  Widget _buildExpenseSummary(BuildContext context, String title, int amount) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: FontStyles.regular.copyWith(color: Colors.white)),
          SizedBox(height: 8),
          Text('Rp. $amount', style: FontStyles.boldItalic.copyWith(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildExpenseSummaryMonth(BuildContext context, String title, int amount) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.customColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: FontStyles.regular.copyWith(color: Colors.white)),
          SizedBox(height: 8),
          Text('Rp. $amount', style: FontStyles.boldItalic.copyWith(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildCategorySummary(BuildContext context, Map<String, int> categoryTotals) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categoryTotals.entries.map((entry) {
          return _buildCategoryCard(
            context,
            entry.key,
            'Rp. ${entry.value}',
            _getIconForCategory(entry.key),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String category, String amount, Widget iconWidget) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, spreadRadius: 1, blurRadius: 5),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconWidget,
          SizedBox(height: 8),
          Text(category, style: TextStyle(fontSize: 14)),
          SizedBox(height: 8),
          Text(amount, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildExpenseList(BuildContext context, List<Expense> expenses) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemCount: expenses.length,
          itemBuilder: (context, index) {
            final expense = expenses[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              color: AppColors.backgroundColor,
              elevation: 4, // Mengatur ketinggian bayangan
              child: ListTile(
                leading: _getIconForCategory(expense.category),
                title: Text(expense.description, style: FontStyles.regularList),
                trailing: Text('Rp. ${expense.amount}'),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _getIconForCategory(String category) {
    switch (category) {
      case 'Makanan':
        return Image.asset('assets/icons/ic_makanan.png', scale: 1.5);
      case 'Internet':
        return Image.asset('assets/icons/ic_internet.png', scale: 1.5);
      case 'Transport':
        return Image.asset('assets/icons/ic_transport.png', scale: 1.5);
      case 'Edukasi':
        return Image.asset('assets/icons/ic_edukasi.png', scale: 1.5);
      case 'Belanja':
        return Image.asset('assets/icons/ic_belanja.png', scale: 1.5);
      case 'Hiburan':
        return Image.asset('assets/icons/ic_hiburan.png', scale: 1.5);
      case 'Alat Rumah':
        return Image.asset('assets/icons/ic_alatrumah.png', scale: 1.5);
      case 'Olahraga':
        return Image.asset('assets/icons/ic_olahraga.png', scale: 1.5);
      case 'Hadiah':
        return Image.asset('assets/icons/ic_hadiah.png', scale: 1.5);
      default:
        return Image.asset('assets/icons/ic_default.png', scale: 1.5); // Default icon
    }
  }
}
