/*
Course: MAD201 - Assignment 2
Author: Jennyfer Parmar
Student ID: A00201240
File: screens/expense_detail_screen.dart
Description: Read-only screen to display details of a selected expense.
*/

import 'package:flutter/material.dart';
import 'package:assignment2_practice_jennyfer/models/expenses.dart';

/// Displays all fields of an [Expense] in a simple, read-only layout.
class ExpenseDetailScreen extends StatelessWidget {
final Expense expense;


const ExpenseDetailScreen({super.key, required this.expense});


String _fmtDate(DateTime d) {
String two(int n) => n.toString().padLeft(2, '0');
return '${d.year}-${two(d.month)}-${two(d.day)}';
}
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: const Text('Expense Details'),
),
body: Padding(
padding: const EdgeInsets.all(16.0),
child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
expense.title,
style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
),
const SizedBox(height: 12),
Row(
children: [
const Text('Amount: ', style: TextStyle(fontWeight: FontWeight.w600)),
Text(expense.amount.toStringAsFixed(2)),
],
),
const SizedBox(height: 8),
Row(
children: [
const Text('Date: ', style: TextStyle(fontWeight: FontWeight.w600)),
Text(_fmtDate(expense.date)),
],
),
const SizedBox(height: 16),
const Text('Description:', style: TextStyle(fontWeight: FontWeight.w600)),
const SizedBox(height: 6),
Container(
width: double.infinity,
padding: const EdgeInsets.all(12),
decoration: BoxDecoration(
border: Border.all(color: Colors.black12),
borderRadius: BorderRadius.circular(8),
),
child: Text(
expense.description.isEmpty ? '—' : expense.description,
style: const TextStyle(fontSize: 16),
),
),
],
),
),
);
}
}