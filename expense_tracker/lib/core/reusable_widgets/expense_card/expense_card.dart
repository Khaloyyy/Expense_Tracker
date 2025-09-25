import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseCard extends StatelessWidget {
  final String description;
  final double amount;
  final DateTime date;
  final String category;

  const ExpenseCard({
    super.key,
    required this.description,
    required this.amount,
    required this.date,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(17.0),
        child: Row(
          children: [
            // Category Icon or Initial
            CircleAvatar(
              backgroundColor: Colors.black,
              child: Icon(
                category.toLowerCase() == 'bills'
                    ? Icons.receipt_long
                    : category.toLowerCase() == 'transportation'
                    ? Icons.directions_car
                    : category.toLowerCase() == 'food'
                    ? Icons.fastfood
                    : category.toLowerCase() == 'shopping'
                    ? Icons.shopping_bag
                    : Icons.category,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    DateFormat('h:mm a').format(date),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            // Amount
            Text(
              "₦${amount.toStringAsFixed(2)}",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
