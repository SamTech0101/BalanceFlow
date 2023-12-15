import 'package:BalanceFlow/model/transaction_message.dart';
import 'package:BalanceFlow/ui/widgets/pie_chart_indicator.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/time_period.dart';
import '../../utils/colors.dart';

class PieChartBalance extends StatefulWidget {
  final List<TransactionMessage> transactionMessage;

   PieChartBalance({super.key ,required this.transactionMessage});

  @override
  _PieChartBalanceState createState() => _PieChartBalanceState();
}

class _PieChartBalanceState extends State<PieChartBalance> {
  TimePeriod selectedPeriod = TimePeriod.daily;
  int touchedIndex = -1;

  List<TransactionMessage> get currentTransactionMessage => widget.transactionMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () => setState(() => selectedPeriod = TimePeriod.daily),
              child: const Text('Day'),
            ),
            ElevatedButton(
              onPressed: () => setState(() => selectedPeriod = TimePeriod.weekly),
              child: const Text('Week'),
            ),
            ElevatedButton(
              onPressed: () => setState(() => selectedPeriod = TimePeriod.monthly),
              child: const Text('Month'),
            ),
          ],
        ),
        SizedBox(height: 38,),
        Expanded(
          child: PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 60,
              centerSpaceColor: Colors.yellow.shade200,
              sections: showingSections(selectedPeriod),
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex = pieTouchResponse
                        .touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              borderData: FlBorderData(
                  show: false
              ),

            ),
          ),
        ),
        const Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Indicator(
              color: AppColors.contentColorRed,
              text: 'Expense',
              isSquare: true,
            ),
            SizedBox(
              height: 4,
            ),
            Indicator(
              color: AppColors.contentColorGreen,
              text: 'Incom',
              isSquare: true,
            ),
            SizedBox(
              height: 18,
            ),
          ],
        ),
        const SizedBox(
          width: 28,
        ),
        // ... other widgets
      ],
    );
  }
  List<PieChartSectionData> showingSections(TimePeriod period ) {
    double totalIncome = 0.0;
    double totalExpense = 0.0;

    for (var transaction in currentTransactionMessage ) {
      bool shouldAdd = false;
      switch (period) {
        case TimePeriod.daily:
          shouldAdd = transaction.date.year == DateTime.now().year &&
              transaction.date.month == DateTime.now().month &&
              transaction.date.day == DateTime.now().day;
          break;

        case TimePeriod.weekly:
          int currentWeek = getWeekOfYear(DateTime.now());
          shouldAdd = getWeekOfYear(transaction.date) == currentWeek && transaction.date.year == DateTime.now().year;
          break;
        case TimePeriod.monthly:
          String currentMonthKey = DateFormat('yyyy-MM').format(DateTime.now());
          shouldAdd = DateFormat('yyyy-MM').format(transaction.date) == currentMonthKey;
          break;
      }

      if (shouldAdd) {
        if (transaction.type == TransactionType.credit) {
          totalIncome += transaction.amount;
        } else  {
          totalExpense += transaction.amount;
        }
      }
    }

    double total = totalIncome + totalExpense;
    if (total == 0) {
      return [
        PieChartSectionData(
          color: Colors.grey, // Default color when there are no transactions
          value: 100, // Occupy the whole chart
          title: '0%',
        )
      ];
    }

    return [
      PieChartSectionData(
          color: Colors.green, // Color for income
          value: totalIncome / total * 100,
          title: '${(totalIncome / total * 100).roundToDouble()}%',
          titleStyle: const TextStyle(color: Colors.white,fontSize: 14),
          radius: 60
      ),
      PieChartSectionData(
          color: Colors.red, // Color for expense
          value: totalExpense / total * 100,
          title: '${(totalExpense / total * 100).roundToDouble()}%',
          titleStyle: const TextStyle(color: Colors.white,fontSize: 14),
          radius: 60
      ),
    ];


  }
}




int getWeekOfYear(DateTime date) {
  final startOfYear = DateTime(date.year, 1, 1);
  final firstMonday = startOfYear.weekday == DateTime.monday
      ? startOfYear
      : startOfYear.add(Duration(days: DateTime.monday - startOfYear.weekday));
  final daysDifference = date.difference(firstMonday).inDays;
  return (daysDifference / 7).ceil();
}