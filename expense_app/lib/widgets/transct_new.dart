import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransctNew extends StatefulWidget {
  final Function addTx;

  TransctNew(this.addTx);

  @override
  _TransctNewState createState() => _TransctNewState();
}

class _TransctNewState extends State<TransctNew> {
  final _titleCrtl = TextEditingController();
  final _amountCrtl = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _addTransct() {
    final enteredTitle = _titleCrtl.text;
    final enteredAmount = double.parse(_amountCrtl.text);
    final enteredDate = _selectedDate;

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }
    widget.addTx(
      enteredTitle,
      enteredAmount,
      enteredDate,
    );
    Navigator.of(context).pop();
  }

  void _datePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _selectedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleCrtl,
                onSubmitted: (_) => _addTransct(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountCrtl,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _addTransct(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No date'
                          : DateFormat.yMEd().format(_selectedDate)),
                    ),
                    FlatButton(
                      onPressed: _datePicker,
                      child: Text(
                        'Choose',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ),
              FlatButton(
                onPressed: _addTransct,
                child: Text('ADD'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
              )
            ],
          ),
        ),
      ),
    );
  }
}
