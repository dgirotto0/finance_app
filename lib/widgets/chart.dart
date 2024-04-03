import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../data/model/add_date.dart';
import '../data/utlity.dart';

class Chart extends StatefulWidget {
  final int indexx;
  const Chart({super.key, required this.indexx});

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  late List<Add_data>? data;
  late List<SalesData> salesData;

  @override
  void initState() {
    super.initState();
    switch (widget.indexx) {
      case 0:
        data = today();
        break;
      case 1:
        data = week();
        break;
      case 2:
        data = month();
        break;
      case 3:
        data = year();
        break;
      default:
    }
    salesData = _generateSalesData(data ?? []);
  }

  List<SalesData> _generateSalesData(List<Add_data> data) {
    return List.generate(data.length, (index) {
      final datetime = data[index].datetime;
      final xValue = widget.indexx == 0 ? datetime.hour.toString() : datetime.day.toString();
      final yValue = index > 0 ? time(data, true)[index] + time(data, true)[index - 1] : time(data, true)[index];
      return SalesData(xValue, yValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: SfCartesianChart(
        primaryXAxis: const CategoryAxis(),
        series: <SplineSeries<SalesData, String>>[
          SplineSeries<SalesData, String>(
            color: const Color.fromARGB(255, 47, 125, 121),
            width: 3,
            dataSource: salesData,
            xValueMapper: (SalesData sales, _) => sales.year,
            yValueMapper: (SalesData sales, _) => sales.sales,
          )
        ],
      ),
    );
  }
}

class SalesData {
  final String year;
  final int sales;

  SalesData(this.year, this.sales);
}