import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class LineChartBalance extends StatelessWidget {
  const LineChartBalance({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      transactionBalanceData,
      duration: const Duration(milliseconds: 250),
    );
  }

  LineChartData get transactionBalanceData => LineChartData(
        lineTouchData: lineTouchTransactionBalanceData,
        gridData: gridData,
        titlesData: titlesTransactionBalanceData,
        borderData: borderData,
        lineBarsData: lineBarsData1,
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

  List<LineChartBarData> get lineBarsData1 =>
      [
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

  FlGridData get gridData => const FlGridData(show: false);

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
        /// green line
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
