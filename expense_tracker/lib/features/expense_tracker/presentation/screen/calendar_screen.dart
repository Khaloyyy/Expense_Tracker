import 'package:expense_tracker/features/expense_tracker/presentation/widgets/calendar_view/calendar_view_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/reusable_widgets/scroll_control/scroll_conntrol.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

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
    SizedBox(height: 50),
    Center(
      child: Container(
        alignment: Alignment.center,
        width: double.maxFinite,
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: CalendarViewScreen(),
      ),
    ),
  ];
}
