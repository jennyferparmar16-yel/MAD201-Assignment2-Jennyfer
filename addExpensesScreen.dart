/*
Course: MAD201 - Assignment 2
Author: Jennyfer Parmar 
Student ID: A00201240
File: screens/add_expense_screen.dart
Description: Screen with a form to create a new expense. Validates inputs and returns the created item.
*/

import 'package:flutter/material.dart';
import 'package:assignment2_practice_jennyfer/models/expenses.dart';

/// Screen to add a new [Expense]. Returns the created expense via Navigator.pop.
class AddExpenseScreen extends StatefulWidget {
const AddExpenseScreen({super.key});


@override
State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}


class _AddExpenseScreenState extends State<AddExpenseScreen> {
final _formKey = GlobalKey<FormState>();
final _titleCtrl = TextEditingController();
final _amountCtrl = TextEditingController();
final _descCtrl = TextEditingController();
DateTime? _selectedDate;

@override
void dispose() {
_titleCtrl.dispose();
_amountCtrl.dispose();
_descCtrl.dispose();
super.dispose();
}

/// Formats a date as YYYY-MM-DD. Returns a placeholder if null.
String _dateLabel(DateTime? d) {
if (d == null) return 'Pick a date';
String two(int n) => n.toString().padLeft(2, '0');
return '${d.year}-${two(d.month)}-${two(d.day)}';
}

Future<void> _pickDate() async {
final now = DateTime.now();
final first = DateTime(now.year - 5);
final last = DateTime(now.year + 5);


final picked = await showDatePicker(
context: context,
initialDate: _selectedDate ?? now,
firstDate: first,
lastDate: last,
);


if (picked != null) {
setState(() {
_selectedDate = picked;
});
}
}

void _save() {
// Validate simple rules: non-empty title, valid amount (>0), date selected
if (!_formKey.currentState!.validate()) return;
if (_selectedDate == null) {
ScaffoldMessenger.of(context).showSnackBar(
const SnackBar(content: Text('Please select a date.')),
);
return;
}


final amount = double.tryParse(_amountCtrl.text.trim());


final expense = Expense(
title: _titleCtrl.text.trim(),
amount: amount!,
description: _descCtrl.text.trim(),
date: _selectedDate!,
);

// Return the new expense to the HomeScreen
Navigator.pop(context, expense);
}


@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(title: const Text('Add Expense')),
body: SingleChildScrollView(
padding: const EdgeInsets.all(16),
child: Form(
key: _formKey,
child: Column(
crossAxisAlignment: CrossAxisAlignment.stretch,
children: [
// Title
TextFormField(
controller: _titleCtrl,
decoration: const InputDecoration(
labelText: 'Expense Title',
hintText: 'e.g., Groceries',
),
validator: (val) {
if (val == null || val.trim().isEmpty) {
return 'Please enter a title';
}
return null;
},
),
const SizedBox(height: 12),
// Amount
TextFormField(
controller: _amountCtrl,
decoration: const InputDecoration(
labelText: 'Amount',
hintText: 'e.g., 25.50',
),
keyboardType: const TextInputType.numberWithOptions(
signed: false,
decimal: true,
),
validator: (val) {
final text = val?.trim() ?? '';
final parsed = double.tryParse(text);
if (parsed == null || parsed <= 0) {
return 'Enter a valid positive number';
}
return null;
},
),
const SizedBox(height: 12),
// Description
TextFormField(
controller: _descCtrl,
decoration: const InputDecoration(
labelText: 'Description',
hintText: 'Optional details (e.g., store, notes)',
),
maxLines: 3,
),
const SizedBox(height: 12),


// Date picker row
Row(
children: [
Expanded(
child: Text(
_dateLabel(_selectedDate),
style: const TextStyle(fontSize: 16),
),
),
TextButton.icon(
onPressed: _pickDate,
icon: const Icon(Icons.calendar_today),
label: const Text('Pick Date'),
),
],
),
const SizedBox(height: 20),


// Save button
ElevatedButton.icon(
onPressed: _save,
icon: const Icon(Icons.save),
label: const Text('Save'),
),
],
),
),
),
);
}
}