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
        minX: 0,
        maxX: 14,
        maxY: 7,
        minY: 0.5,
      );

  LineTouchData get lineTouchTransactionBalanceData => LineTouchData(
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
    ),
  );

  FlTitlesData get titlesTransactionBalanceData => FlTitlesData(
    bottomTitles: AxisTitles(
      sideTitles: bottomTitles,
    ),
    rightTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    topTitles: const AxisTitles(
      sideTitles: SideTitles(showTitles: false),
    ),
    leftTitles: AxisTitles(
      sideTitles: leftTitles(),
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
    String text;
    switch (value.toInt()) {
      case 1:
        text = '1m';
        break;
      case 2:
        text = '2m';
        break;
      case 3:
        text = '3m';
        break;
      case 4:
        text = '5m';
        break;
      case 5:
        text = '6m';
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
    getTitlesWidget: leftTitleWidgets,
    showTitles: true,
    interval: 1,
    reservedSize: 40,
  );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = const Text('SEPT', style: style);
        break;
      case 7:
        text = const Text('OCT', style: style);
        break;
      case 12:
        text = const Text('DEC', style: style);
        break;
      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
    showTitles: true,
    reservedSize: 32,
    interval: 1,
    getTitlesWidget: bottomTitleWidgets,
  );

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
    barWidth: 8,
    isStrokeCapRound: true,
    dotData: const FlDotData(show: false),
    belowBarData: BarAreaData(show: false),
    spots: const [
      FlSpot(1, 1),
      FlSpot(3, 1.5),
      FlSpot(5, 1.4),
      FlSpot(7, 3.4),
      FlSpot(10, 2),
      FlSpot(12, 2.2),
      FlSpot(13, 1.8),
    ],
  );

  LineChartBarData get lineChartBarExpense => LineChartBarData(
    isCurved: true,
    color: AppColors.contentColorPink,
    barWidth: 8,
    isStrokeCapRound: true,
    dotData: const FlDotData(show: false),
    belowBarData: BarAreaData(
      show: false,
      color: AppColors.contentColorPink.withOpacity(0),
    ),
    spots: const [
      FlSpot(1, 1),
      FlSpot(3, 2.8),
      FlSpot(7, 1.2),
      FlSpot(10, 2.8),
      FlSpot(12, 2.6),
      FlSpot(13, 3.9),
    ],
  );

  LineChartBarData get lineChartBarTotal => LineChartBarData(
    isCurved: true,
    color: AppColors.contentColorCyan,
    barWidth: 8,
    isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: const [
          FlSpot(1, 2.8),
          FlSpot(3, 1.9),
          FlSpot(6, 3),
          FlSpot(10, 1.3),
          FlSpot(13, 2.5),
        ],
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
      String weekKey =
          '${transaction.date.year}-${DateFormat('w').format(transaction.date)}';

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
    int index = 0;

    balance.forEach((key, value) {
      spots.add(FlSpot(index.toDouble(), value));
      index++;
    });

    return spots;
  }

  //Map
  Map<String, double> weeklyMap() {
    transactions.sort((a, b) => a.date.compareTo(b.date));
    // Convert transactions to weekly map
    Map<String, double> weeklyMap = {};
    for (var transaction in transactions) {
      String weekNumber =
          '${transaction.date.year}-${DateFormat('w').format(transaction.date)}';
      if (!weeklyMap.containsKey(weekNumber)) {
        weeklyMap[weekNumber] = 0.0;
      }
      weeklyMap[weekNumber] = (weeklyMap[weekNumber] ?? 0.0) +
          transaction.amount *
              (transaction.transactionType == 'income' ? 1 : -1);
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
      monthlyMap[monthYear] = (monthlyMap[monthlySpots] ?? 0.0) +
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
        expose.add(FlSpot(xValue.toDouble(), entry.value));
      }
    });
    if (transactionType == "income") {
      return income;
    } else {
      return expose;
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
        expose.add(FlSpot(x.toDouble(), entry.value));
      }
    });
    if (transactionType == "income") {
      return income;
    } else {
      return expose;
    }
  }

  List<FlSpot> weeklySpot(String transactionType) {
    List<FlSpot> income = [];
    List<FlSpot> expose = [];
    weeklyMap().entries.map((entry) {
      // Extract year and week number from the key
      List<String> parts = entry.key.split('-');
      int year = int.parse(parts[0]);
      int weekNumber = int.parse(parts[1]);
      // Calculate x-value based on year and week number
      int xValue = (year - 2023) * 52 + weekNumber;
      // Return FlSpot with x and y values

      if (entry.value > 0) {
        income.add(FlSpot(xValue.toDouble(), entry.value));
      } else {
        expose.add(FlSpot(xValue.toDouble(), entry.value));
      }
    });
    if (transactionType == "income") {
      return income;
    } else {
      return expose;
    }
  }
}

///////////

///////////
///////////
//
// class LineChartSample2 extends StatefulWidget {
//   const LineChartSample2({Key? key}) : super(key: key);
//
//   @override
//   _LineChartSample2State createState() => _LineChartSample2State();
// }
//
// class _LineChartSample2State extends State<LineChartSample2> {
//   ViewType _currentView = ViewType.daily;
//   FlTitlesData get titlesData1 => FlTitlesData(
//     bottomTitles: AxisTitles(
//       sideTitles: bottomTitles,
//     ),
//     rightTitles: const AxisTitles(
//       sideTitles: SideTitles(showTitles: false),
//     ),
//     topTitles: const AxisTitles(
//       sideTitles: SideTitles(showTitles: false),
//     ),
//     leftTitles: AxisTitles(
//       sideTitles: leftTitles(),
//     ),
//   );
//
//   SideTitles get bottomTitles => SideTitles(
//     showTitles: true,
//     reservedSize: 32,
//     interval: 1,
//     getTitlesWidget: bottomTitleWidgets,
//   );
//   SideTitles leftTitles() => SideTitles(
//     getTitlesWidget: leftTitleWidgets,
//     showTitles: true,
//     interval: 1,
//     reservedSize: 40,
//   );
//   Widget bottomTitleWidgets(double value, TitleMeta meta) {
//     const style = TextStyle(
//       fontWeight: FontWeight.bold,
//       fontSize: 16,
//     );
//     Widget text;
//     switch (value.toInt()) {
//       case 2:
//         text = const Text('SEPT', style: style);
//         break;
//       case 7:
//         text = const Text('OCT', style: style);
//         break;
//       case 12:
//         text = const Text('DEC', style: style);
//         break;
//       default:
//         text = const Text('');
//         break;
//     }
//
//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       space: 10,
//       child: text,
//     );
//   }
//   Widget leftTitleWidgets(double value, TitleMeta meta) {
//     const style = TextStyle(
//       fontWeight: FontWeight.bold,
//       fontSize: 14,
//     );
//     String text;
//     switch (value.toInt()) {
//       case 1:
//         text = '1m';
//         break;
//       case 2:
//         text = '2m';
//         break;
//       case 3:
//         text = '3m';
//         break;
//       case 4:
//         text = '5m';
//         break;
//       case 5:
//         text = '6m';
//         break;
//       default:
//         return Container();
//     }
//
//     return Text(text, style: style, textAlign: TextAlign.center);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: () => _changeView(ViewType.daily),
//               child: Text('Daily'),
//             ),
//             ElevatedButton(
//               onPressed: () => _changeView(ViewType.weekly),
//               child: Text('Weekly'),
//             ),
//             ElevatedButton(
//               onPressed: () => _changeView(ViewType.monthly),
//               child: Text('Monthly'),
//             ),
//           ],
//         ),
//         const SizedBox(height: 16),
//         AspectRatio(
//           aspectRatio: 1.3,
//           child: LineChart(
//             lineChartData(),
//           ),
//         ),
//       ],
//     );
//   }
//
//   void _changeView(ViewType viewType) {
//     setState(() {
//       _currentView = viewType;
//     });
//   }
//
//   LineChartData lineChartData() {
//     return LineChartData(
//       gridData: FlGridData(show: false),
//       titlesData: titlesData1,
//       borderData: FlBorderData(
//         show: true,
//         border: Border.all(
//           color: const Color(0xff37434d),
//           width: 1,
//         ),
//       ),
//       minX: 0,
//       maxX: 7,
//       minY: 0,
//       maxY: 6,
//       lineBarsData: [
//         LineChartBarData(
//           spots: _currentView == ViewType.daily
//               ? dailySpots()
//               : _currentView == ViewType.weekly
//               ? weeklySpots()
//               : monthlySpots(),
//           isCurved: true,
//           color: Colors.blue,
//           dotData: FlDotData(show: false),
//           belowBarData: BarAreaData(show: false),
//         ),
//       ],
//     );
//   }
//
//   List<FlSpot> dailySpots() {
//     // Replace this with your logic to get daily income and expense values
//     return [
//       FlSpot(0, 3),
//       FlSpot(1, 1),
//       FlSpot(2, 4),
//       FlSpot(3, 2),
//       FlSpot(4, 3),
//       FlSpot(5, 1),
//       FlSpot(6, 4),
//       FlSpot(7, 2),
//     ];
//   }
//
//   AxisTitles dailyBottomTitles() {
//     return AxisTitles(
//       bottomTitles: bottomTitles,
//     );
//   }
//
//   SideTitles get bottomTitles => SideTitles(
//     showTitles: true,
//     reservedSize: 32,
//     interval: 1,
//     getTitlesWidget: bottomTitleWidgets,
//   );
//
//   Widget bottomTitleWidgets(double value, TitleMeta meta) {
//     const style = TextStyle(
//       fontWeight: FontWeight.bold,
//       fontSize: 16,
//     );
//     Widget text;
//     switch (value.toInt()) {
//       case 2:
//         text = const Text('SEPT', style: style);
//         break;
//       case 7:
//         text = const Text('OCT', style: style);
//         break;
//       case 12:
//         text = const Text('DEC', style: style);
//         break;
//       default:
//         text = const Text('');
//         break;
//     }
//
//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       space: 10,
//       child: text,
//     );
//   }
//
//
//   AxisTitles weeklyBottomTitles() {
//     return AxisTitles(
//       showTitles: true,
//       getTextStyles: (value) => const TextStyle(color: Colors.white),
//       interval: 1,
//     );
//   }
//
//   AxisTitles monthlyBottomTitles() {
//     return AxisTitles(
//       showTitles: true,
//       getTextStyles: (value) => const TextStyle(color: Colors.white),
//       interval: 1,
//     );
//   }
//
//   AxisTitles leftTitles() {
//     return AxisTitles(
//       showTitles: true,
//       getTextStyles: (value) => const TextStyle(color: Colors.white),
//       interval: 1,
//     );
//   }
//
//   FlTitlesData get titlesData1 => FlTitlesData(
//     bottomTitles: AxisTitles(
//       sideTitles: _currentView == ViewType.daily
//           ? dailyBottomTitles()
//           : _currentView == ViewType.weekly
//           ? weeklyBottomTitles()
//           : monthlyBottomTitles(),
//     ),
//     rightTitles: const AxisTitles(
//       sideTitles: SideTitles(showTitles: false),
//     ),
//     topTitles: const AxisTitles(
//       sideTitles: SideTitles(showTitles: false),
//     ),
//     leftTitles: AxisTitles(
//       sideTitles: leftTitles(),
//     ),
//   );
// }
List<FlSpot> weeklySpots() {
  // Replace this with your logic to get weekly income and expense values
  return [
    FlSpot(0, 5),
    FlSpot(1, 3),
    FlSpot(2, 6),
    FlSpot(3, 4),
    FlSpot(4, 5),
    FlSpot(5, 3),
    FlSpot(6, 6),
  ];
}

List<FlSpot> monthlySpots() {
  // Replace this with your logic to get monthly income and expense values
  return [
    FlSpot(0, 8),
    FlSpot(1, 6),
    FlSpot(2, 9),
    FlSpot(3, 7),
    FlSpot(4, 8),
    FlSpot(5, 6),
    FlSpot(6, 9),
    FlSpot(7, 7),
  ];
}

enum ViewType {
  daily,
  weekly,
  monthly,
}
