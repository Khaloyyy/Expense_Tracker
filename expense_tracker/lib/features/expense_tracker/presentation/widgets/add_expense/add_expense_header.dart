import 'package:flutter/material.dart';

class AddExpenseHeader extends StatelessWidget {
  const AddExpenseHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Add New Expense',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Enter the details of your expese to help you track your spending',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                  maxLines: 2,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
