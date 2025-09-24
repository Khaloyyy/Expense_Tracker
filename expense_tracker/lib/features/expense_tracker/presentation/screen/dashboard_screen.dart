import 'package:expense_tracker/features/expense_tracker/presentation/widgets/dashboard/header.dart';
import 'package:flutter/material.dart';

import '../../../../core/reusable_widgets/scroll_control/scroll_conntrol.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[

          // ================== Body ======================== //
          Expanded(
            child: ScrollControllerWidget(
              widgetList: bodyScrollableList(),
            ),
          ),
            // ========== Navigation Bar ============= //
          //  const DesktopNavigation(),
        ],
      ),
    );
  }
}

List<Widget> bodyScrollableList() {
  // =============== List of Widgets Body ============== //

  return <Widget>[
    // ==================== Contents ========================= //

    SizedBox(
      height: 100,
    ),
    
    Container(
      alignment: Alignment.center,
      width: double.maxFinite,
      margin: const EdgeInsets.symmetric(horizontal: 30),
      child: HeaderWidget()
    )

    // Container(
    //   alignment: Alignment.center,
    //   width: double.maxFinite,
    //   margin: const EdgeInsets.symmetric(horizontal: 30),
    //   child: const BoxConstraintsWidth(
    //     widgetContent: HelpCenterBodyDesktop(),
    //   ),
    // ),
    // const SizedBox(
    //   height: 100,
    // ),

    // // ==================== Footer ====================== //
    // const DFooterSection(),
  ];
}
