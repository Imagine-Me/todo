import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class PieChartWidget extends StatelessWidget {
  const PieChartWidget(
      {Key? key, required this.dataMap, required this.colorList})
      : super(key: key);
  final Map<String, double> dataMap;
  final List<Color> colorList;

  @override
  Widget build(BuildContext context) {
    return PieChart(
      dataMap: dataMap,
      animationDuration: const Duration(seconds: 1),
      chartRadius: MediaQuery.of(context).size.width / 1.5,
      chartType: ChartType.ring,
      ringStrokeWidth: 32,
      chartLegendSpacing: 32,
      centerText: "TODO",
      colorList: colorList,
      chartValuesOptions: const ChartValuesOptions(decimalPlaces: 0),
      legendOptions: const LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.bottom,
        showLegends: true,
        legendTextStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600
        ),
      ),
    );
  }
}
