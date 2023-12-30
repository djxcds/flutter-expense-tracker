import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.addNewExpense, {super.key});

  final void Function(Expense expense) addNewExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final DateTime now = DateTime.now();
    final DateTime firstDate = DateTime(now.year - 1, now.month, now.day);
    final DateTime? value = await showDatePicker(
        context: context,
        firstDate: firstDate,
        lastDate: now,
        initialDate: now);
    setState(() {
      if (value != null) {
        _selectedDate = value;
      }
    });
  }

  void _submitExpenseData() {
    final double? enteredAmount = double.tryParse(_amountController.text);
    final bool amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text('Please fill all input correctly.'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('OK'))
          ],
        ),
      );
      return;
    }

    widget.addNewExpense(Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory));
    closeDialog(context);
  }

  void closeDialog(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return LayoutBuilder(builder: (ctx, constraints) {
      final double maxWidth = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {
                      closeDialog(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: _submitExpenseData,
                    child: const Text('Save Expense'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
                  child: Column(children: [
                    if (maxWidth >= 600)
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: TextField(
                              maxLength: 50,
                              controller: _titleController,
                              decoration:
                                  const InputDecoration(label: Text('Title')),
                            ),
                          ),
                          const SizedBox(
                            width: 24,
                          ),
                          Expanded(
                            child: TextField(
                              controller: _amountController,
                              decoration: const InputDecoration(
                                  label: Text('Amount'), prefixText: '\$'),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      )
                    else
                      TextField(
                        maxLength: 50,
                        controller: _titleController,
                        decoration: const InputDecoration(label: Text('Title')),
                      ),
                    if (maxWidth >= 600)
                      Row(
                        children: [
                          DropdownButton(
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .color),
                            value: _selectedCategory,
                            items: Category.values
                                .map((val) => DropdownMenuItem(
                                      value: val,
                                      child: Text(val.name.toUpperCase()),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              if (value == null) return;
                              setState(() {
                                _selectedCategory = value;
                              });
                            },
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(_selectedDate == null
                                    ? 'Selected Date'
                                    : formatter.format(_selectedDate!)),
                                IconButton(
                                    onPressed: _presentDatePicker,
                                    icon: const Icon(Icons.calendar_month))
                              ],
                            ),
                          )
                        ],
                      )
                    else
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _amountController,
                              decoration: const InputDecoration(
                                  label: Text('Amount'), prefixText: '\$'),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(_selectedDate == null
                                    ? 'Selected Date'
                                    : formatter.format(_selectedDate!)),
                                IconButton(
                                    onPressed: _presentDatePicker,
                                    icon: const Icon(Icons.calendar_month))
                              ],
                            ),
                          )
                        ],
                      ),
                    const SizedBox(height: 20),
                    // if (maxWidth >= 600)
                    //   Row(
                    //     children: [
                    //       const Spacer(),
                    //       TextButton(
                    //         onPressed: () {
                    //           closeDialog(context);
                    //         },
                    //         child: const Text('Cancel'),
                    //       ),
                    //       const SizedBox(width: 10),
                    //       ElevatedButton(
                    //         onPressed: _submitExpenseData,
                    //         child: const Text('Save Expense'),
                    //       ),
                    //     ],
                    //   )
                    // else
                    Row(
                      children: [
                        DropdownButton(
                          style: TextStyle(
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .color),
                          value: _selectedCategory,
                          items: Category.values
                              .map((val) => DropdownMenuItem(
                                    value: val,
                                    child: Text(val.name.toUpperCase()),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                        // const Spacer(),
                        // TextButton(
                        //   onPressed: () {
                        //     closeDialog(context);
                        //   },
                        //   child: const Text('Cancel'),
                        // ),
                        // const SizedBox(width: 10),
                        // ElevatedButton(
                        //   onPressed: _submitExpenseData,
                        //   child: const Text('Save Expense'),
                        // ),
                      ],
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
