
import 'package:BalanceFlow/utils/theme_utils.dart';
import 'package:flutter/material.dart';

class AddTransactionDialog extends StatefulWidget {
  @override
  _AddTransactionDialogState createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<AddTransactionDialog> {
  bool _isIncome = true; // This tracks the income/expense toggle state.
  DateTime _selectedDate = DateTime.now(); // This tracks the selected date.

  // This function is called when the user picks a date.
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
             Text(
              'Add Transaction',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),

            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.attach_money),
                labelText: 'Amount',
                border: OutlineInputBorder(),
                labelStyle: TextStyle(color: Colors.grey)
              ),
              keyboardType: TextInputType.number,

            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.note),
                // labelText: 'Note on Transaction',
                  label: Text("Note on Transaction",),
                  labelStyle: TextStyle(color: Colors.grey ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ChoiceChip(
                  selectedColor: ThemeData().primaryColor,
                  label: Text('Income',style: TextStyle(color: _isIncome ? Colors.white : Colors.black54),),
                  selected: _isIncome,
                  onSelected: (selected) {
                    setState(() {
                      _isIncome = true;
                    });
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color:!_isIncome ? Colors.white : Colors.black54,)),
                ),
                SizedBox(width: 10),
                ChoiceChip(
                  selectedColor: ThemeData().primaryColor,
                  label: Text('Expense',style: TextStyle(color: !_isIncome ? Colors.white : Colors.black54),),
                  selected: !_isIncome,
                  onSelected: (selected) {
                    setState(() {
                      _isIncome = false;
                    });
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12), side: BorderSide(color:_isIncome ? Colors.white : Colors.black54,)),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                TextButton(
                  onPressed: _presentDatePicker,
                  child: Text(
                    'Choose Date',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  ' ${_selectedDate.day}-${_selectedDate.month}-${_selectedDate.year}',
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement transaction add functionality.
              },
              child: Text('Add'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 36), // double.infinity is the width and 36 is the height
              ),
            ),
          ],
        ),
      ),
    );
  }
}
