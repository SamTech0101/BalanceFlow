import 'package:BalanceFlow/model/total_balance.dart';
import 'package:flutter/material.dart';

class TotalBalanceWidget extends StatelessWidget {
  final TotalBalanceModel totalBalanceModel;

  const TotalBalanceWidget({super.key, required this.totalBalanceModel});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child:  Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Total Balance',
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            "₹ ${totalBalanceModel.totalBalance}",
            style: TextStyle(fontSize: 36.0, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Icon(Icons.arrow_downward, color: Colors.green),
                  SizedBox(height: 4),
                  Text('Income', style: TextStyle(color: Colors.white)),
                  Text('${totalBalanceModel.income}', style: TextStyle(color: Colors.white)),
                ],
              ),
              Column(
                children: <Widget>[
                  Icon(Icons.arrow_upward, color: Colors.red),
                  SizedBox(height: 4),
                  Text('Expense', style: TextStyle(color: Colors.white)),
                  Text('${totalBalanceModel.expense}', style: TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}