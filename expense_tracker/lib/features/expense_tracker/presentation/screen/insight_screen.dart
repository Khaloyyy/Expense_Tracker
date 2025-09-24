import 'package:flutter/material.dart';

import '../../../../core/reusable_widgets/scroll_control/scroll_conntrol.dart';

class InsightScreen extends StatelessWidget {
  const InsightScreen({super.key});

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
    // ==================== Help Center Body ========================= //
    SizedBox(height: 100),
    Center(
      child: Container(
        alignment: Alignment.center,
        width: double.maxFinite,
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Text('Insights Coming Soon'),
      ),
    ),

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
