/*
Course: MAD201 - Assignment 2
Author: jennyfer Parmar
Student ID: A00201240
File: screens/home_screen.dart
Description: Home screen showing list of expenses, total summary, and FAB to add a new expense.
*/

import 'package:flutter/material.dart';
import 'package:assignment2_practice_jennyfer/models/expenses.dart';
import 'package:assignment2_practice_jennyfer/screens/addExpensesScreen.dart';
import 'package:assignment2_practice_jennyfer/screens/expenseDetailsScreen.dart';

// The main landing screen that lists all recorded expenses.
class HomeScreen extends StatefulWidget {
const HomeScreen({super.key});


@override
State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
/// In-memory list of expenses for this session.
final List<Expense> _expenses = [];


/// Returns a human-friendly date string like YYYY-MM-DD.
String _fmtDate(DateTime d) {
String two(int n) => n.toString().padLeft(2, '0');
return '${d.year}-${two(d.month)}-${two(d.day)}';
}
/// Computes the total of all expense amounts.
double get _total => _expenses.fold(0.0, (sum, e) => sum + e.amount);


@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Personal Expense Tracker'),
),
floatingActionButton: FloatingActionButton(
onPressed: () async {
// Navigate to AddExpenseScreen and wait for the result.
final Expense? newExpense = await Navigator.push(
context,
MaterialPageRoute(builder: (_) => const AddExpenseScreen()),
);


// If an expense was returned, add it to the list.
if (newExpense != null) {
setState(() {
_expenses.add(newExpense);
});
}
},
child: const Icon(Icons.add),
),
body: Column(
children: [
// Optional: Total summary at the top
Card(
margin: const EdgeInsets.all(12),
child: Padding(
padding: const EdgeInsets.all(16.0),
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
const Text(
'Total Expense',
style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
),
Text(
_total.toStringAsFixed(2),
style: const TextStyle(
fontSize: 18,
fontWeight: FontWeight.bold,
),
),
],
),
),
),
// List of expenses
Expanded(
child: _expenses.isEmpty
? const Center(
child: Text('No expenses yet. Tap + to add one.'),
)
: ListView.builder(
itemCount: _expenses.length,
itemBuilder: (context, index) {
final e = _expenses[index];
return Card(
margin: const EdgeInsets.symmetric(
horizontal: 12,
vertical: 6,
),
child: ListTile(
title: Text(e.title),
subtitle: Text(_fmtDate(e.date)),
trailing: Text(
e.amount.toStringAsFixed(2),
style: const TextStyle(
fontWeight: FontWeight.bold,
),
),
onTap: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (_) => ExpenseDetailScreen(expense: e),
),
);
},
),
);
},
),
),
],
),
);
}
}
