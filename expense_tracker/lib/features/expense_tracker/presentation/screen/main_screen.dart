import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'insight_screen.dart';
import 'add_expense_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0; // Initial value is DashboardScreen

  final List<Widget> _screens = [
    DashboardScreen(),
    InsightScreen(),
    AddExpenseScreen(),
  ];

  void _onNavBarTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onFloatingTap() {
    setState(() {
      _selectedIndex = 2; // AddExpenseScreen
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        onPressed: _onFloatingTap,
        tooltip: 'Add Expense',
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 40,
        notchMargin: 5,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home),
              onPressed: () => _onNavBarTap(0),
            ),
            const SizedBox(width: 50),
            IconButton(
              icon: const Icon(Icons.pie_chart),
              onPressed: () => _onNavBarTap(1),
            ),
          ],
        ),
      ),
      body: _screens[_selectedIndex],
    );
  }
}
