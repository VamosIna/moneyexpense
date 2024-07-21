import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:moneyexp/models/expense_models.dart';
import 'package:moneyexp/ui/category_screen.dart';
import 'package:moneyexp/utils/colors.dart';
import 'package:moneyexp/utils/fonts.dart';
import '../cubit/expense_cubit.dart';

class AddExpenseScreen extends StatefulWidget {
  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  bool isNow = false;
  String _selectedCategory = 'Makanan';
  Widget _categoryIcon = Image.asset('assets/icons/ic_makanan.png', scale: 1.5);

  Future<void> _selectCategory(BuildContext context) async {
    final category = await showModalBottomSheet<String>(
      context: context,
      builder: (context) {
        return CategoryBottomSheet(
          onCategorySelected: (selectedCategory) {
            setState(() {
              _selectedCategory = selectedCategory;
              _categoryIcon = _getIconForCategory(selectedCategory);
            });
          },
        );
      },
    );
    if (category != null) {
      setState(() {
        _selectedCategory = category;
        _categoryIcon = _getIconForCategory(category);
      });
    }
  }

  final List<String> categories = [
    'Makanan',
    'Internet',
    'Transport',
    'Edukasi',
    'Belanja',
    'Hiburan',
    'Alat Rumah',
    'Olahraga',
    'Hadiah'
  ];

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

  void _validateForm() {
    setState(() {}); // Triggers build to update validation status
  }

  @override
  Widget build(BuildContext context) {
    bool isFormValid = _formKey.currentState?.validate() ?? false;

    String formattedDate = DateFormat('dd MMMM yyyy').format(_selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Pengeluaran Baru', style: FontStyles.bold),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 70,
                child: TextFormField(
                  minLines: 1,
                  maxLines: 1,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    labelText: 'Nama Pengeluaran',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.customColor2)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.customColor2)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.customColor2)
                    ),
                  ),
                  controller: _descriptionController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onChanged: (value) => _validateForm(),
                ),
              ),
              // SizedBox(height: 8),
              GestureDetector(
                onTap: () => _selectCategory(context),
                child: AbsorbPointer(
                  child: SizedBox(
                    height: 50,
                    child: TextFormField(
                      minLines: 1,
                      maxLines: 1,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 16),
                        prefixIcon: _categoryIcon,
                        suffixIcon: Icon(Icons.keyboard_arrow_right_rounded),
                        labelText: 'Kategori',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.customColor2)
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.customColor2)
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.customColor2)
                        ),
                      ),
                      controller: TextEditingController(text: _selectedCategory),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.customColor2),
                ),
                child: ListTile(
                  title: isNow == false ? Text('Tanggal') : Text('Tanggal: $formattedDate'),
                  trailing: Icon(Icons.calendar_month, size: 20),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: _selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null && pickedDate != _selectedDate) {
                      setState(() {
                        _selectedDate = pickedDate;
                        isNow = true;
                        _validateForm();
                      });
                    }
                  },
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 150,
                child: TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    labelText: 'Nominal',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.customColor2)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.customColor2)
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: AppColors.customColor2)
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an amount';
                    }
                    return null;
                  },
                  onChanged: (value) => _validateForm(),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: isFormValid ? AppColors.primaryColor : AppColors.customColor2,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: isFormValid
                      ? () {
                    final expense = Expense(
                      id: DateTime.now().millisecondsSinceEpoch,
                      description: _descriptionController.text,
                      category: _selectedCategory,
                      amount: int.parse(_amountController.text),
                      date: _selectedDate,
                    );

                    context.read<ExpenseCubit>().addExpense(expense);
                    Navigator.pop(context);
                  }
                      : null,
                  child: Text(
                    'Simpan',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
