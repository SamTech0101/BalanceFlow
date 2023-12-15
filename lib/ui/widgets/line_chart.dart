import 'dart:ffi';

import 'package:BalanceFlow/model/fake_transactions.dart';
import 'package:BalanceFlow/utils/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/time_period.dart';
import '../../utils/colors.dart';

class LineChartBalance extends StatefulWidget {
  LineChartBalance({super.key});

  @override
  State<LineChartBalance> createState() => _LineChartBalanceState();
}

class _LineChartBalanceState extends State<LineChartBalance> {
  TimePeriod selectedPeriod = TimePeriod.daily;

  @override
  Widget build(BuildContext context) {
    return Column(

      children: [
        Expanded(
          child: LineChart(
            transactionBalanceData,
          ),
        ),
        SizedBox(
          height: 38,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () =>
                  setState(() => selectedPeriod = TimePeriod.daily),
              child: const Text('Daily'),
            ),
            ElevatedButton(
              onPressed: () =>
                  setState(() => selectedPeriod = TimePeriod.weekly),
              child: const Text('Weekly'),
            ),
            ElevatedButton(
              onPressed: () =>
                  setState(() => selectedPeriod = TimePeriod.monthly),
              child: const Text('Monthly'),
            ),
          ],
        ),
      ],
    );
  }

  LineChartData get transactionBalanceData => LineChartData(
    lineTouchData: lineTouchTransactionBalanceData,
        titlesData: titlesTransactionBalanceData,
        borderData: borderData,
        lineBarsData: lineBarsTransactionBalanceData,
        minX: -10,
        maxX: 55,
        maxY: 600,
        minY: 0,
      );

  LineTouchData get lineTouchTransactionBalanceData => LineTouchData(
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
    ),
  );

  FlTitlesData get titlesTransactionBalanceData => FlTitlesData(
    // bottomTitles: AxisTitles(
    //   sideTitles: bottomTitles,
    // ),
    bottomTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    // leftTitles: AxisTitles(
    //   sideTitles: leftTitles(),
    // ),
    leftTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
  );

  List<LineChartBarData> get lineBarsTransactionBalanceData => [
        lineChartBarIncome,
        lineChartBarExpense,
        lineChartBarTotal,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text = "value";


    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
    getTitlesWidget: leftTitleWidgets,
    showTitles: true,
    interval: 1,
    reservedSize: 40,
  );

  // Widget bottomTitleWidgets(double value, TitleMeta meta) {
  //   const style = TextStyle(
  //     fontWeight: FontWeight.bold,
  //     fontSize: 16,
  //   );
  //   Widget text;
  //   switch (value.toInt()) {
  //     case 2:
  //       text = const Text('SEPT', style: style);
  //       break;
  //     case 7:
  //       text = const Text('OCT', style: style);
  //       break;
  //     case 12:
  //       text = const Text('DEC', style: style);
  //       break;
  //     default:
  //       text = const Text('');
  //       break;
  //   }
  //
  //   return SideTitleWidget(
  //     axisSide: meta.axisSide,
  //     space: 10,
  //     child: text,
  //   );
  // }

  // SideTitles get bottomTitles => SideTitles(
  //   showTitles: true,
  //   reservedSize: 32,
  //   interval: 1,
  //   getTitlesWidget: bottomTitleWidgets,
  // );

  FlBorderData get borderData => FlBorderData(
    show: true,
    border: Border(
      bottom:
      BorderSide(color: AppColors.primary.withOpacity(0.2), width: 4),
      left: BorderSide(color: AppColors.primary.withOpacity(0.2), width: 4),
      right: const BorderSide(color: Colors.transparent),
      top: const BorderSide(color: Colors.transparent),
    ),
  );

  LineChartBarData get lineChartBarIncome => LineChartBarData(
    isCurved: true,
    color: AppColors.contentColorGreen,
    barWidth: 2,
    isStrokeCapRound: true,
    dotData: const FlDotData(show: false),
    belowBarData: BarAreaData(show: false),
    spots:weeklySpot("income",false),
  );

  LineChartBarData get lineChartBarExpense => LineChartBarData(
    isCurved: true,
    color: AppColors.contentColorPink,
    barWidth: 2,
    isStrokeCapRound: true,
    dotData: const FlDotData(show: false),
    belowBarData: BarAreaData(
      show: false,
      color: AppColors.contentColorPink.withOpacity(0),
    ),
    spots:weeklySpot("expense",false)
  );

  LineChartBarData get lineChartBarTotal => LineChartBarData(
    isCurved: true,
    color: AppColors.contentColorCyan,
    barWidth: 4,
    isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: weeklySpot("",true),
      );

  //--------------------------------------------
  Map<String, Map<String, double>> totalBalanceMap() {
    // Sort transactions by date
    transactions.sort((a, b) => a.date.compareTo(b.date));

    // Calculate total balance for each day, month, and week
    Map<String, double> dailyBalance = {};
    Map<String, double> monthlyBalance = {};
    Map<String, double> weeklyBalance = {};
    Map<String, Map<String, double>> totalBalance = {};
    for (var transaction in transactions) {
      // Calculate day, month, and week identifiers
      String dayKey = DateFormat('yyyy-MM-dd').format(transaction.date);
      String monthKey = DateFormat('yyyy-MM').format(transaction.date);
      String weekKey =getIsoWeekNumber(transaction.date).replaceAll('W', '');
      // Update daily balance
      dailyBalance[dayKey] = (dailyBalance[dayKey] ?? 0) +
          (transaction.transactionType == 'income'
              ? transaction.amount
              : -transaction.amount);
      // Update monthly balance
      monthlyBalance[monthKey] = (monthlyBalance[monthKey] ?? 0) +
          (transaction.transactionType == 'income'
              ? transaction.amount
              : -transaction.amount);
      // Update weekly balance
      weeklyBalance[weekKey] = (weeklyBalance[weekKey] ?? 0) +
          (transaction.transactionType == 'income'
              ? transaction.amount
              : -transaction.amount);
    }
    totalBalance[dailyTitle] = dailyBalance;
    totalBalance[weeklyTitle] = weeklyBalance;
    totalBalance[monthlyTitle] = monthlyBalance;
    return totalBalance;
  }

  List<FlSpot> convertTotalBalanceToFlSpot(Map<String, double> balance) {
    List<FlSpot> spots = [];

    balance.forEach((key, value) {
      spots.add(FlSpot(double.parse(key), value));
    });

    return spots;
  }
  String getIsoWeekNumber(DateTime date) {
    // Find the Thursday in this week
    DateTime thursday = date.subtract(Duration(days: date.weekday - 4));

    // Calculate the ISO week number
    int isoWeekNumber = thursday.difference(DateTime(thursday.year, 1, 1)).inDays ~/ 7 + 1;

    // Return the ISO week number as a string
    return '${thursday.year}-W${isoWeekNumber.toString().padLeft(2, '0')}';
  }


  //Map
  Map<String, double> weeklyMap(bool isTotal) {
    transactions.sort((a, b) => a.date.compareTo(b.date));
    // Convert transactions to weekly map
    Map<String, double> weeklyMap = {};
    Map<String, double> weeklyTotalMap = {};
    for (var transaction in transactions) {
      String weekNumber = getIsoWeekNumber(transaction.date).replaceAll('W', '');

      if (!weeklyMap.containsKey(weekNumber)) {
        weeklyMap[weekNumber] = 0.0;
        weeklyTotalMap[weekNumber] = 0.0;
      }
      weeklyMap[weekNumber] = (weeklyMap[weekNumber] ?? 0.0) +
          transaction.amount *
              (transaction.transactionType == 'income' ? 1 : -1);

      if (transaction.transactionType == 'income'){
        weeklyTotalMap[weekNumber] =   (weeklyTotalMap[weekNumber] ?? 0.0) + transaction.amount;
      }else{
        weeklyTotalMap[weekNumber] =   (weeklyTotalMap[weekNumber] ?? 0.0) - transaction.amount;
      }
    }

  if(isTotal){
    return weeklyTotalMap;
  }
    return weeklyMap;
  }

  Map<String, double> monthlyMap() {
    transactions.sort((a, b) => a.date.compareTo(b.date));
// Convert transactions to monthly map
    Map<String, double> monthlyMap = {};
    for (var transaction in transactions) {
      String monthYear = '${transaction.date.year}-${transaction.date.month}';
      if (!monthlyMap.containsKey(monthYear)) {
        monthlyMap[monthYear] = 0.0;
      }
      monthlyMap[monthYear] = (monthlyMap[monthYear] ?? 0.0) +
          transaction.amount *
              (transaction.transactionType == 'income' ? 1 : -1);
    }
    return monthlyMap;
  }

  Map<String, double> dailyMap() {
    transactions.sort((a, b) => a.date.compareTo(b.date));
    // Convert transactions to daily map
    Map<String, double> dailyMap = {};
    for (var transaction in transactions) {
      String dateKey = DateFormat('yyyy-MM-dd').format(transaction.date);
      if (!dailyMap.containsKey(dateKey)) {
        dailyMap[dateKey] = 0.0;
      }
      dailyMap[dateKey] = (dailyMap[dateKey] ?? 0.0) +
          transaction.amount *
              (transaction.transactionType == 'income' ? 1 : -1);
    }
    return dailyMap;
  }

//FlSpot
  List<FlSpot> dailySpot(String transactionType) {
    List<FlSpot> income = [];
    List<FlSpot> expose = [];
    dailyMap().entries.map((entry) {
      // Extract year, month, and day from the key
      List<String> parts = entry.key.split('-');
      int year = int.parse(parts[0]);
      int month = int.parse(parts[1]);
      int day = int.parse(parts[2]);

      // Calculate x-value based on year, month, and day ref Date : 2023, 12, 1
      int xValue =
          DateTime(year, month, day).difference(DateTime(2023, 12, 1)).inDays +
              1;
      // Return FlSpot with x and y values

      if (entry.value > 0) {
        income.add(FlSpot(xValue.toDouble(), entry.value));
      } else {
        expose.add(FlSpot(xValue.toDouble(), entry.value*(-1)));
      }
    });
    if (transactionType == "income") {
      return income;
    } else {
      return expose;
    }
  }

  List<FlSpot> weeklySpot(String transactionType , bool isTotal) {
    List<FlSpot> income = [];
    List<FlSpot> expense = [];
    List<FlSpot> total = [];
    weeklyMap(isTotal).forEach((key, value) {
      List<String> parts = key.split('-');
      int year = int.parse(parts[0]);
      int weekNumber = int.parse(parts[1]);
      int xValue = (year - 2023) * 52 + weekNumber;
       if (isTotal){
         total.add(FlSpot(xValue.toDouble(), value));
       }else if (value > 0) {
        income.add(FlSpot(xValue.toDouble(), value));
      } else {
         expense.add(FlSpot(xValue.toDouble(),value*(1)));
      }
    });


    if (transactionType == "income") {
      return income;
    } else if(transactionType == "expense") {
      return expense;
    }else {
      return total;
    }
  }
  List<FlSpot> dailyTotalSpat() {
    return convertTotalBalanceToFlSpot(totalBalanceMap()[dailyTitle]!);
  }

  List<FlSpot> monthlyTotalSpat() {
    return convertTotalBalanceToFlSpot(totalBalanceMap()[monthlyTitle]!);
  }

  List<FlSpot> weeklyTotalSpat() {
    return convertTotalBalanceToFlSpot(totalBalanceMap()[weeklyTitle]!);
  }

  List<FlSpot> monthlySpot(String transactionType) {
    List<FlSpot> income = [];
    List<FlSpot> expose = [];
    monthlyMap().entries.map((entry) {
      // Split the key to get year and month
      List<String> parts = entry.key.split('-');
      int year = int.parse(parts[0]);
      int month = int.parse(parts[1]);

      // Calculate X-coordinate as months since the start
      double x = (year - 2023) * 12 + month.toDouble();
      // Create FlSpot
      // Return FlSpot with x and y values

      if (entry.value > 0) {
        income.add(FlSpot(x.toDouble(), entry.value));
      } else {

        expose.add(FlSpot(x.toDouble(), entry.value*(-1)));
      }
    });
    if (transactionType == "income") {
      return income;
    } else {
      return expose;
    }
  }


}
