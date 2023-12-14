import 'package:BalanceFlow/ui/widgets/fake_transactions.dart';
import 'package:BalanceFlow/ui/widgets/pie_chart.dart';
import 'package:BalanceFlow/utils/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/time_period.dart';
import 'line_chart.dart';
import 'pie_chart_indicator.dart';


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
          SizedBox(
            width: 400,height: 350,
            // child: LineChartSample(transactions: transactions,),
            child: PieChartBalance(),
          ),
          SizedBox(
            width: 400,height: 300,
            // child: LineChartSample(transactions: transactions,),
            child: PieChartBalance(),
          )
        ],
      ),
    );

  }

}

////////////////////////////////////
///////////////////////////////////
///////////////////////////////////
