import 'package:expense_tracker/features/expense_tracker/presentation/widgets/dashboard/header.dart';
import 'package:expense_tracker/features/expense_tracker/presentation/widgets/dashboard/option_button.dart';
import 'package:expense_tracker/features/expense_tracker/presentation/widgets/dashboard/summary_card.dart';
import 'package:flutter/material.dart';

import '../../../../core/reusable_widgets/scroll_control/scroll_conntrol.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      //   onPressed: () {},
      //   tooltip: 'Add Expense',
      //   backgroundColor: Colors.black,
      //   child: const Icon(Icons.add, color: Colors.white),
      // ),
      // bottomNavigationBar: BottomAppBar(
      //   height: 40,
      //   notchMargin: 5,
      //   shape: CircularNotchedRectangle(),
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //     children: <Widget>[
      //       IconButton(icon: const Icon(Icons.home), onPressed: () {}),
      //       SizedBox(width: 50),
      //       IconButton(icon: const Icon(Icons.pie_chart), onPressed: () {}),
      //     ],
      //   ),
      // ),
      body: Column(
        children: <Widget>[
          // ================== Body ======================== //
          Expanded(
            child: ScrollControllerWidget(widgetList: bodyScrollableList()),
          ),
        ],
      ),
    );
  }
}

List<Widget> bodyScrollableList() {
  // =============== List of Widgets Body ============== //

  return <Widget>[
    // ==================== Contents ========================= //
    SizedBox(height: 100),

    Container(
      alignment: Alignment.topLeft,
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: HeaderWidget(),
    ),
    SizedBox(height: 10),
    Container(
      alignment: Alignment.topLeft,
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: OptionButton(),
    ),
    SizedBox(height: 10),

    Container(
      alignment: Alignment.center,
      width: double.maxFinite,
      child: SummaryCard(),
    ),
    // const SizedBox(
    //   height: 100,
    // ),

    // // ==================== Footer ====================== //
    // const DFooterSection(),
  ];
}
