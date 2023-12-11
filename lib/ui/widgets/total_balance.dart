import 'package:flutter/material.dart';

class TotalBalanceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Total Balance',
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            'Rs 460',
            style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(Icons.arrow_downward, color: Colors.green),
                  SizedBox(height: 4),
                  Text('Income', style: TextStyle(color: Colors.white)),
                  Text('1000', style: TextStyle(color: Colors.white)),
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(Icons.arrow_upward, color: Colors.red),
                  SizedBox(height: 4),
                  Text('Expense', style: TextStyle(color: Colors.white)),
                  Text('540', style: TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}