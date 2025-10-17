/*
Course: MAD201 - Assignment 2
Author: Jennyfer Parmar
Student ID: A00201240
File: models/expense.dart
Description: Defines the Expense data model used across the app.
*/

/// Represents a single expense item with title, amount, description and date.
class Expense {
/// Title or label for the expense (e.g., "Groceries").
final String title;


/// Monetary amount of the expense.
final double amount;


/// Additional details describing the expense.
final String description;


/// The date on which the expense occurred.
final DateTime date;


/// Creates a new [Expense] instance.
Expense({
required this.title,
required this.amount,
required this.description,
required this.date,
});
}