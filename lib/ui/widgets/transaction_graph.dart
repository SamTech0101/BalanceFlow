import 'package:flutter/material.dart';

import 'line_chart.dart';


class TransactionGraph extends StatefulWidget {
  const TransactionGraph({super.key});

  @override
  _TransactionGraphState createState() => _TransactionGraphState();
}

class _TransactionGraphState extends State<TransactionGraph> {


  @override
  Widget build(BuildContext context) {
    return      Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // SizedBox(
          //   width: 400,height: 350,
          //   // child: LineChartSample(transactions: transactions,),
          //   child: PieChartBalance(),
          // ),
          SizedBox(
            width: 400, height: 300,
            // child: LineChartSample(transactions: transactions,),
            child: LineChartBalance(),
          )
        ],
      ),
    );

  }

}

////////////////////////////////////
///////////////////////////////////
///////////////////////////////////
