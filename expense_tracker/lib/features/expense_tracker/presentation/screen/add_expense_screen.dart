import 'package:expense_tracker/features/expense_tracker/presentation/widgets/add_expense/add_expense_header.dart';
import 'package:flutter/material.dart';

import '../../../../core/reusable_widgets/scroll_control/scroll_conntrol.dart';
import '../widgets/add_expense/add_expense_body.dart';

class AddExpenseScreen extends StatelessWidget {
  const AddExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // ========== Navigation Bar ============= //

          // ================== Body ======================== //
          Expanded(
            child: ScrollControllerWidget(widgetList: bodyScrollableList()),
          ),

          //  const DesktopNavigation(),
        ],
      ),
    );
  }
}

List<Widget> bodyScrollableList() {
  // =============== List of Widgets Body ============== //

  return <Widget>[
    // ==================== Add Expense Body ========================= //
    SizedBox(height: 100),
    Center(
      child: Container(
        alignment: Alignment.center,
        width: double.maxFinite,
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: AddExpenseHeader(),
      ),
    ),
    const SizedBox(height: 20),
    Container(
      alignment: Alignment.center,
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: AddExpenseBody(),
    ),
  ];
}
