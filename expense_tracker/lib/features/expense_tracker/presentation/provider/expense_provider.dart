import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/model/expense_model.dart';

import 'dart:convert';

final expenseListProvider =
    StateNotifierProvider<ExpenseListNotifier, List<ExpenseModel>>((ref) {
      return ExpenseListNotifier();
    });

class ExpenseListNotifier extends StateNotifier<List<ExpenseModel>> {
  ExpenseListNotifier() : super([]) {
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final expenseJsonList = prefs.getStringList('expenses') ?? [];
    state = expenseJsonList
        .map((e) => ExpenseModel.fromJson(json.decode(e)))
        .toList();
  }

  Future<void> addExpense(ExpenseModel expense) async {
    state = [...state, expense];
    final prefs = await SharedPreferences.getInstance();
    final expenseJsonList = state.map((e) => json.encode(e.toJson())).toList();
    await prefs.setStringList('expenses', expenseJsonList);
  }

  Future<void> removeExpense(ExpenseModel expense) async {
    state = state.where((e) => e.id != expense.id).toList();
    final prefs = await SharedPreferences.getInstance();
    final expenseJsonList = state.map((e) => json.encode(e.toJson())).toList();
    await prefs.setStringList('expenses', expenseJsonList);
  }
}
