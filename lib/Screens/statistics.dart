import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../data/model/add_date.dart';
import '../data/utlity.dart';

class Statistics extends StatefulWidget {
  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  late List<Add_data> _filteredData;
  final List<String> _filterOptions = ['Day', 'Week', 'Month', 'Year'];
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    _filteredData = _filterData(_selectedIndex);
  }

  List<Add_data> _filterData(int index) {
    switch (index) {
      case 0:
        return today();
      case 1:
        return week();
      case 2:
        return month();
      case 3:
        return year();
      default:
        return [];
    }
  }

  void _updateData(int index) {
    setState(() {
      _selectedIndex = index;
      _filteredData = _filterData(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                _filterOptions.length,
                    (index) => ElevatedButton(
                  onPressed: () => _updateData(index),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      index == _selectedIndex ? Colors.deepPurple : Colors.white,
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: BorderSide(color: index == _selectedIndex ? Colors.deepPurple : Colors.white),
                      ),
                    ),
                  ),
                  child: Text(
                    _filterOptions[index],
                    style: TextStyle(
                      fontFamily: 'f',
                      fontWeight: FontWeight.w600,
                      color: index == _selectedIndex ? Colors.white : Colors.deepPurple,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  _buildStackedLineChart(),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Top Spending',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.swap_vert,
                          size: 25,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _filteredData.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                                'assets/img/${_filteredData[index].name}.png',
                                height: 40),
                          ),
                          title: Text(
                            _filteredData[index].name,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            '${_filteredData[index].datetime.day}/${_filteredData[index].datetime.month}/${_filteredData[index].datetime.year}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          trailing: Text(
                            '\$${_filteredData[index].amount}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 19,
                              color: _filteredData[index].IN == 'Income'
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the stacked line chart.
  Widget _buildStackedLineChart() {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      primaryXAxis: const CategoryAxis(
        majorGridLines: MajorGridLines(width: 0),
      ),
      primaryYAxis: NumericAxis(
        minimum: 0,
        maximum: _filteredData.isNotEmpty
            ? _filteredData
            .map((data) => double.parse(data.amount))
            .reduce((a, b) => a > b ? a : b)
            : 0,
        axisLine: const AxisLine(width: 0),
      ),
      series: _getStackedLineSeries(),
    );
  }

  /// Returns the list of chart seris which need to render
  /// on the stacked line chart.
  List<StackedLineSeries<Add_data, String>> _getStackedLineSeries() {
    return <StackedLineSeries<Add_data, String>>[
      StackedLineSeries<Add_data, String>(
        dataSource: _filteredData,
        xValueMapper: (Add_data data, _) => data.datetime.toString(), // Adjust this according to your data structure
        yValueMapper: (Add_data data, _) => double.parse(data.amount),
        markerSettings: const MarkerSettings(isVisible: true),
      ),
    ];
  }
}
