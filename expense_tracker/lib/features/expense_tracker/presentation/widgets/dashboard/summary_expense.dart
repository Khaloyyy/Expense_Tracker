import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/reusable_widgets/expense_card/expense_card.dart';
import '../../../domain/enums/expense_filter.dart';
import '../../../domain/model/expense_model.dart';
import '../../provider/expense_provider.dart';

class SummaryExpense extends ConsumerStatefulWidget {
  final ExpenseFilterType filterType;
  const SummaryExpense({super.key, required this.filterType});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SummaryExpenseState();
}

class _SummaryExpenseState extends ConsumerState<SummaryExpense> {
  List<ExpenseModel> _filterExpenses(List<ExpenseModel> expenses) {
    final now = DateTime.now();
    switch (widget.filterType) {
      case ExpenseFilterType.today:
        return expenses
            .where(
              (e) =>
                  e.date.year == now.year &&
                  e.date.month == now.month &&
                  e.date.day == now.day,
            )
            .toList();
      case ExpenseFilterType.week:
        final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        final endOfWeek = startOfWeek.add(const Duration(days: 6));
        return expenses
            .where(
              (e) =>
                  e.date.isAfter(
                    startOfWeek.subtract(const Duration(seconds: 1)),
                  ) &&
                  e.date.isBefore(endOfWeek.add(const Duration(days: 1))),
            )
            .toList();
      case ExpenseFilterType.month:
        return expenses
            .where((e) => e.date.year == now.year && e.date.month == now.month)
            .toList();
      case ExpenseFilterType.all:
        return expenses;
    }
  }

  void _showExpenseOptions(
    BuildContext context,
    WidgetRef ref,
    ExpenseModel expense,
  ) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('Update'),
                onTap: () {
                  Navigator.pop(context);
                  _showUpdateDialog(context, ref, expense);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete'),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteConfirmation(context, ref, expense);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    WidgetRef ref,
    ExpenseModel expense,
  ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Are you sure you want to delete "${expense.title}"?'),
          content: Text('This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(expenseListProvider.notifier)
                    .deleteExpense(expense.id);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Expense Deleted')),
                );

                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showUpdateDialog(
    BuildContext context,
    WidgetRef ref,
    ExpenseModel expense,
  ) {
    final amountController = TextEditingController(
      text: expense.amount.toString(),
    );
    final descriptionController = TextEditingController(text: expense.title);
    String category = expense.category;

    DateTime selectedDate = expense.date;
    final dateController = TextEditingController(
      text: "${expense.date.toLocal()}".split('.').first,
    );

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Update Expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: amountController,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: category,
                items: [
                  DropdownMenuItem(
                    value: 'Shopping',
                    child: Row(
                      children: [
                        Icon(Icons.shopping_bag),
                        SizedBox(width: 20),
                        Text('Shopping'),
                      ],
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'Food',
                    child: Row(
                      children: [
                        Icon(Icons.fastfood),
                        SizedBox(width: 20),
                        Text('Food'),
                      ],
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
                      children: [
                        Icon(Icons.receipt_long),
                        SizedBox(width: 20),
                        Text('Bills'),
                      ],
                    ),
                  ),
                ],
                onChanged: (value) {
                  if (value != null) category = value;
                },
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              const SizedBox(height: 20),
              TextField(
                readOnly: true,
                controller: dateController,
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
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    final TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(selectedDate),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        selectedDate = DateTime(
                          pickedDate.year,
                          pickedDate.month,
                          pickedDate.day,
                          pickedTime.hour,
                          pickedTime.minute,
                        );
                        dateController.text = "${selectedDate.toLocal()}"
                            .split('.')
                            .first;
                      });
                    }
                  }
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final updatedExpense = ExpenseModel(
                  id: expense.id,
                  title: descriptionController.text,
                  amount:
                      double.tryParse(amountController.text) ?? expense.amount,
                  date: selectedDate,
                  category: category,
                );
                ref
                    .read(expenseListProvider.notifier)
                    .updateExpense(updatedExpense);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Expense Updated')),
                );

                Navigator.pop(context);
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final expenseList = ref.watch(expenseListProvider);
    final filteredExpenses = _filterExpenses(expenseList);

    if (filteredExpenses.isEmpty) {
      return const Center(child: Text('No expenses yet.'));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: filteredExpenses.length,
      itemBuilder: (context, index) {
        final expense = filteredExpenses[index];
        return GestureDetector(
          onTap: () => _showExpenseOptions(context, ref, expense),
          child: ExpenseCard(
            description: expense.title,
            amount: expense.amount,
            date: expense.date,
            category: expense.category,
          ),
        );
      },
    );
  }
}
