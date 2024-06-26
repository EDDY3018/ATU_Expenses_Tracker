import 'package:flutter/material.dart';

import '../../models/expense.dart';
import 'expense_item.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.expenses, required this.onRemove});

  final List<Expense> expenses;
  final Function onRemove;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (context, index) => Dismissible(
          key: ValueKey(expenses[index]),
          onDismissed: (direction) => onRemove(expenses[index]),
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.85),
            margin: Theme.of(context).cardTheme.margin,
          ),
          child: ExpenseItem(expense: expenses[index])),
    );
  }
}
