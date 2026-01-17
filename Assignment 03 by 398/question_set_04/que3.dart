import 'dart:io';

void main() {
  List<double> expenses = [];
  print("Enter 5 expenses:");
  for (int i = 0; i < 5; i++) {
    stdout.write("Expense ${i + 1}: ");
    double expense = double.parse(stdin.readLineSync()!);
    expenses.add(expense);
  }

  double total = expenses.reduce((a, b) => a + b);
  print("Total expenses: $total");
}