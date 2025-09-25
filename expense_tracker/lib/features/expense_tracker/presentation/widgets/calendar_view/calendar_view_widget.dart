import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../provider/expense_provider.dart';
import '../../../domain/model/expense_model.dart';
import '../../../../../core/reusable_widgets/expense_card/expense_card.dart';

class CalendarViewScreen extends ConsumerStatefulWidget {
  const CalendarViewScreen({super.key});

  @override
  ConsumerState<CalendarViewScreen> createState() => _CalendarViewScreenState();
}

class _CalendarViewScreenState extends ConsumerState<CalendarViewScreen> {
  DateTime _selectedDay = DateTime.now();

  List<ExpenseModel> _expensesForDay(
    List<ExpenseModel> expenses,
    DateTime day,
  ) {
    return expenses
        .where(
          (e) =>
              e.date.year == day.year &&
              e.date.month == day.month &&
              e.date.day == day.day,
        )
        .toList();
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
    final expenses = ref.watch(expenseListProvider);
    final dayExpenses = _expensesForDay(expenses, _selectedDay);
    final total = dayExpenses.fold<double>(0, (sum, e) => sum + e.amount);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,

                color: const Color.fromARGB(255, 255, 255, 255),
              ),
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.black, size: 30),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            const SizedBox(width: 30),
            const Text(
              'Calendar View',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ],
        ),

        SizedBox(height: 10),

        TableCalendar(
          availableCalendarFormats: const {
            CalendarFormat.month: 'Month',
            CalendarFormat.twoWeeks: '----',
            CalendarFormat.week: 'Week',
          },
          firstDay: DateTime.utc(2000, 1, 1),
          lastDay: DateTime.utc(2100, 12, 31),
          focusedDay: _selectedDay,
          selectedDayPredicate: (day) =>
              day.year == _selectedDay.year &&
              day.month == _selectedDay.month &&
              day.day == _selectedDay.day,
          onDaySelected: (selectedDay, focusedDay) {
            setState(() {
              _selectedDay = selectedDay;
            });
          },
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: Text(
                DateFormat('EEEE, d MMMM').format(_selectedDay),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Divider(),

            Expanded(
              child: Text(
                '₦${total.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Flexible(
          fit: FlexFit.loose,
          child: dayExpenses.isEmpty
              ? const Center(child: Text('No expenses for this day.'))
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: dayExpenses.length,
                  itemBuilder: (context, index) {
                    final expense = dayExpenses[index];
                    return GestureDetector(
                      onTap: () {
                        _showExpenseOptions(context, ref, expense);
                      },
                      child: ExpenseCard(
                        description: expense.title,
                        amount: expense.amount,
                        date: expense.date,
                        category: expense.category,
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
