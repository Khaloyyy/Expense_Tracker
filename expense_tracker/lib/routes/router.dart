
import 'package:expense_tracker/features/expense_tracker/presentation/screen/calendar_screen.dart';
import 'package:expense_tracker/features/expense_tracker/presentation/screen/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/expense_tracker/presentation/screen/add_expense_screen.dart';


part 'router.g.dart';

final navigatorKey = GlobalKey<NavigatorState>();

List<GoRoute> get routes => [
      // ================= Add-Expense Screen ================= //
       GoRoute(
        name: '/add-expense',
        path: '/add-expense',
        builder: (context, state) => const AddExpenseScreen(),
        // builder: (context, state) => const SplashScreen(),
      ),

      // ================= Calendar-View Screen ================= //
      GoRoute(
        name: '/calendar-view',
        path: '/calendar-view',
        builder: (context, state) => const CalendarScreen(),
      ),
      
      // ================= Dashboard Screen ================= //
      GoRoute(
        name: '/dashboard',
        path: '/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),

      
    ];

@riverpod
GoRouter goRoute(Ref ref) {  

  return GoRouter(
    routes: routes,
    initialLocation: '/dashboard',
    navigatorKey: navigatorKey,
  );
}
