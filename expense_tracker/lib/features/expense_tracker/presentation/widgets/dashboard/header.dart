import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 60.0,
          height: 60.0,
          decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
        ),

        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Morning, Carlo!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(width: 10),

            Text(
              'Track your expenses, start your day right!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey, // Set the text color to grey here
              ),
            ),
          ],
        ),
      ],
    );
  }
}
