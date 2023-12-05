// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Auth/login.dart';
import 'components/chart/chart.dart';
import 'components/expenses/expense_list.dart';
import 'components/expenses/new_expense.dart';
import 'config/deleteCache.dart';
import 'config/firebase/firebaseAuth.dart';
import 'config/sharePreference.dart';
import 'models/expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final FireAuth _fireAuth = FireAuth();

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
      appBar: AppBar(title: Text('Expense Tracker'), actions: [
        IconButton(
            onPressed: () {
              showLogoutBottomSheet(context);
            },
            icon: Icon(Icons.logout_rounded))
      ]),
      floatingActionButton:
          FloatingActionButton(onPressed: _showModal, child: Icon(Icons.add)),
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

  void showLogoutBottomSheet(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return CupertinoActionSheet(
          title: Text('Are you sure you want to Logout?'),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () async {
                await _fireAuth.signOut();
                await saveBoolShare(key: "auth", data: false);
                await deleteCache();
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              child: Text('Logout'),
              isDestructiveAction: true,
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
        );
      },
    );
  }
}
