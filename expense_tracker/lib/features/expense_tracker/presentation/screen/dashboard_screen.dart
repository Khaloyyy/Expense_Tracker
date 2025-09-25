import 'package:expense_tracker/features/expense_tracker/presentation/widgets/dashboard/dashboard_widget_screen.dart';
import 'package:expense_tracker/features/expense_tracker/presentation/widgets/dashboard/header.dart';
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
      child: DashboardWidgetScreen(),
    ),
  ];
}
