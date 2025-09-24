import 'package:flutter/material.dart';
import '../../../domain/enums/expense_filter.dart';
import 'option_button.dart';
import 'summary_card.dart';
import 'summary_expense.dart';

class DashboardWidgetScreen extends StatefulWidget {
  const DashboardWidgetScreen({super.key});

  @override
  State<DashboardWidgetScreen> createState() => _DashboardWidgetScreenState();
}

class _DashboardWidgetScreenState extends State<DashboardWidgetScreen> {
  ExpenseFilterType _filterType = ExpenseFilterType.all;

  void _onFilterChanged(ExpenseFilterType type) {
    setState(() {
      _filterType = type;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: OptionButton(
            selected: _filterType,
            onSelected: _onFilterChanged,
          ),
        ),

        const SizedBox(height: 10),
        SummaryCard(filterType: _filterType),
        const SizedBox(height: 10),
        SummaryExpense(filterType: _filterType),
      ],
    );
  }
}
