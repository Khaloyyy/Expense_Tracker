import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/model/expense_model.dart';
import '../../provider/expense_provider.dart';

class AddExpenseBody extends ConsumerStatefulWidget {
  const AddExpenseBody({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddExpenseBodyState();
}

class _AddExpenseBodyState extends ConsumerState<AddExpenseBody> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final List<DropdownMenuItem<String>> _categoryController =
      <DropdownMenuItem<String>>[];
  String? _selectedCategory;
  DateTime? _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _categoryController.addAll([
      DropdownMenuItem(
        value: 'Shopping',
        child: Row(
          children: [
            Icon(Icons.shopping_cart),
            SizedBox(width: 20),
            Text('Shopping'),
          ],
        ),
      ),
      DropdownMenuItem(
        value: 'Food',
        child: Row(
          children: [Icon(Icons.fastfood), SizedBox(width: 20), Text('Food')],
        ),
      ),
      DropdownMenuItem(
        value: 'Transportation',
        child: Row(
          children: [
            Icon(Icons.directions_car),
            SizedBox(width: 20),
            Text('Transportation'),
          ],
        ),
      ),
      DropdownMenuItem(
        value: 'Bills',
        child: Row(
          children: [Icon(Icons.receipt), SizedBox(width: 10), Text('Bills')],
        ),
      ),
    ]);
    _selectedDateTime = DateTime.now();
  }

  @override
  void dispose() {
    amountController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _saveExpense() {
    final expense = ExpenseModel(
      id: const Uuid().v4(),
      title: descriptionController.text,
      amount: double.tryParse(amountController.text) ?? 0,
      date: _selectedDateTime ?? DateTime.now(),
      category: _selectedCategory ?? '',
    );
    ref.read(expenseListProvider.notifier).addExpense(expense);
    amountController.clear();
    descriptionController.clear();
    setState(() {
      _selectedCategory = 'Category';
      _selectedDateTime = DateTime.now();
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Expense Saved')));
    debugPrint('Expense Saved: ${expense.toJson()}');
    // Optionally clear fields or show a success message
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        // AddExpenseHeader(),
        const SizedBox(height: 20),
        TextField(
          controller: amountController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Enter Amount',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: descriptionController,
          decoration: InputDecoration(
            labelText: 'Description',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
        const SizedBox(height: 20),

        DropdownButtonFormField<String>(
          value: _selectedCategory,
          items: _categoryController,
          onChanged: (value) {
            setState(() {
              _selectedCategory = value;
            });
          },
          decoration: const InputDecoration(
            labelText: 'Category',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        ),

        const SizedBox(height: 20),

        TextField(
          readOnly: true,
          controller: TextEditingController(
            text: _selectedDateTime != null
                ? "${_selectedDateTime!.toLocal()}".split('.').first
                : '',
          ),
          decoration: InputDecoration(
            labelText: 'Date & Time',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            suffixIcon: Icon(Icons.calendar_today),
          ),
          onTap: () async {
            final DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: _selectedDateTime ?? DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
            );
            if (pickedDate != null) {
              final TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.fromDateTime(
                  _selectedDateTime ?? DateTime.now(),
                ),
              );
              if (pickedTime != null) {
                setState(() {
                  _selectedDateTime = DateTime(
                    pickedDate.year,
                    pickedDate.month,
                    pickedDate.day,
                    pickedTime.hour,
                    pickedTime.minute,
                  );
                });
              }
            }
          },
        ),

        SizedBox(height: 30),

        Container(
          alignment: Alignment.center,
          width: double.maxFinite,
          child: ElevatedButton(
            onPressed: _saveExpense,

            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text(
              'Save Expense',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
