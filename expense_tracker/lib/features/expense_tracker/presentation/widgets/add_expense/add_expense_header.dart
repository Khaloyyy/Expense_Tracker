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
              decoration: BoxDecoration(
                shape: BoxShape.circle,

                color: const Color.fromARGB(255, 172, 161, 161),
              ),
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            Text(
              'Add New Expense',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Container(
              constraints: BoxConstraints(maxWidth: 300),
              child: Text(
                'Enter the details of your expese to help you track your spending',
                style: TextStyle(fontSize: 14, color: Colors.grey),
                maxLines: 2,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
