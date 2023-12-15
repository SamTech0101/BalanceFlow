import 'package:BalanceFlow/ui/widgets/pie_chart.dart';
import 'package:flutter/material.dart';

import '../../model/transaction_message.dart';



class TransactionGraph extends StatefulWidget {
  final List<TransactionMessage> transactionMessage;

  TransactionGraph({super.key , required this.transactionMessage});

  @override
  _TransactionGraphState createState() => _TransactionGraphState();
}

class _TransactionGraphState extends State<TransactionGraph> {


  @override
  Widget build(BuildContext context) {
    return      Container(
      height: 400,
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),  color: Colors.blueGrey,
      ),
      child: Center(
        child: PieChartBalance(transactionMessage: widget.transactionMessage,),
      ),
    );

  }

}
