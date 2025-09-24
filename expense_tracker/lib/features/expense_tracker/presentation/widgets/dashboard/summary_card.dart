import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/enums/expense_filter.dart';
import '../../provider/expense_provider.dart';
import '../../../domain/model/expense_model.dart';

class SummaryCard extends ConsumerWidget {
  final ExpenseFilterType filterType;
  const SummaryCard({super.key, required this.filterType});

  List<ExpenseModel> _filterExpenses(List<ExpenseModel> expenses) {
    final now = DateTime.now();
    switch (filterType) {
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenseList = ref.watch(expenseListProvider);
    final filteredExpenses = _filterExpenses(expenseList);
    final totalExpenses = filteredExpenses.fold<double>(
      0,
      (sum, expense) => sum + expense.amount,
    );

    return Container(
      height: 100,
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Spend so far',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                '₦${totalExpenses.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
