import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
       
       Container(
          alignment: Alignment.topLeft,
         child: Image.asset('lib/core/assets/header1.png'),
       ),

        const SizedBox(
          height: 20,
        ),

        
      ],
    );
  }
}