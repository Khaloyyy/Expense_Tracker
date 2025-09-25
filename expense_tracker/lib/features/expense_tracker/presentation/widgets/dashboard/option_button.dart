import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../domain/enums/expense_filter.dart';

class OptionButton extends StatelessWidget {
  final ExpenseFilterType selected;
  final ValueChanged<ExpenseFilterType> onSelected;

  const OptionButton({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                _buildButton(context, 'Today', ExpenseFilterType.today),
                const SizedBox(width: 10),
                _buildButton(context, 'This Week', ExpenseFilterType.week),
                const SizedBox(width: 10),
                _buildButton(context, 'This Month', ExpenseFilterType.month),
                const SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      context.push('/calendar-view');
                    },
                    borderRadius: BorderRadius.circular(30.0),
                    child: Container(
                      height: 30,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,

                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(30.0),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'Calendar',
                          style: TextStyle(fontSize: 7.9, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton(
    BuildContext context,
    String label,
    ExpenseFilterType type,
  ) {
    final isSelected = selected == type;
    return Expanded(
      child: InkWell(
        onTap: () => onSelected(type),
        borderRadius: BorderRadius.circular(30.0),
        child: Container(
          height: 30,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.white,
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 7.9,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
