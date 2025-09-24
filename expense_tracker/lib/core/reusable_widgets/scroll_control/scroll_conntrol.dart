import 'package:flutter/material.dart';

class ScrollControllerWidget extends StatelessWidget {
  const ScrollControllerWidget({super.key, required this.widgetList});
  final List<Widget> widgetList;
  // ============================================================== //
  // Purpose of this widget is for smooth scrolling and modify scrolling config
  // Like: Smooth Scroll, Animation etc.
  // ============================================================== //

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        children: widgetList,
      ),
    );
  }
}
