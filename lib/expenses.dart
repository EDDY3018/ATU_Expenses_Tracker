
import 'package:flutter/material.dart';

import 'components/chart/chart.dart';
import 'components/expenses/expense_list.dart';
import 'components/expenses/new_expense.dart';
import 'models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        date: DateTime.now(),
        title: 'Movie Tickets',
        amount: 499.0,
        category: Category.work),
    Expense(
        date: DateTime.now(),
        title: 'Groceries',
        amount: 800.0,
        category: Category.food),
    Expense(
        date: DateTime.now(),
        title: 'Wedding Ceremony',
        amount: 1499.0,
        category: Category.leisure),
  ];

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void onAddExpense(Expense expense) {
    _addExpense(expense);
  }

  void onRemoveExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense deleted'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () => setState(
            () {
              _registeredExpenses.insert(expenseIndex, expense);
            },
          ),
        ),
      ),
    );
  }

  void _showModal() {
    showModalBottomSheet(
        useSafeArea: true,
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpense(onAdd: onAddExpense));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          title: Text('Expense Tracker'),
          actions: [IconButton(onPressed: _showModal, icon: Icon(Icons.add))]),
      body: SafeArea(
          child: width < height
              ? Column(
                  children: [
                    Chart(expenses: _registeredExpenses),
                    Expanded(
                        child: _registeredExpenses.isEmpty
                            ? const Center(
                                child:
                                    Text('No expenses added. Try adding some!'),
                              )
                            : ExpenseList(
                                expenses: _registeredExpenses,
                                onRemove: onRemoveExpense,
                              ))
                  ],
                )
              : Row(
                  children: [
                    Expanded(child: Chart(expenses: _registeredExpenses)),
                    Expanded(
                      child: _registeredExpenses.isEmpty
                          ? const Center(
                              child:
                                  Text('No expenses added. Try adding some!'),
                            )
                          : ExpenseList(
                              expenses: _registeredExpenses,
                              onRemove: onRemoveExpense,
                            ),
                    ),
                  ],
                )),
    );
  }
}
