import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChartScreen(),
    );
  }
}

class ChartScreen extends StatefulWidget {
  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  String _selectedMonth = 'Jun';

  // Data for the pie charts based on the month
  Map<String, Map<String, double>> _monthlyDataBefore = {
    'Mar': {
      'AC': 441.6,
      'Light': 193.2,
      'Fan': 122.64,
    },
    'Apr': {
      'AC': 469.2,
      'Light': 202.4,
      'Fan': 129.76,
    },
    'May': {
      'AC': 496.8,
      'Light': 211.6,
      'Fan': 136.88,
    },
    'Jun': {
      'AC': 524.4,
      'Light': 220.8,
      'Fan': 144,
    },
    'Jul': {
      'AC': 552,
      'Light': 230,
      'Fan': 151.12,
    },
    'Aug': {
      'AC': 579.6,
      'Light': 239.2,
      'Fan': 158.24,
    },
    'Sep': {
      'AC': 607.2,
      'Light': 248.4,
      'Fan': 165.36,
    },
    'Oct': {
      'AC': 634.8,
      'Light': 257.6,
      'Fan': 172.48,
    },
    'Nov': {
      'AC': 662.4,
      'Light': 266.8,
      'Fan': 179.6,
    },
    'Dec': {
      'AC': 690,
      'Light': 276,
      'Fan': 186.72,
    },
  };

  Map<String, Map<String, double>> _monthlyDataAfter = {
    'Mar': {
      'AC': 424.6,
      'Light': 178.2,
      'Fan': 106.64,
    },
    'Apr': {
      'AC': 453.2,
      'Light': 186.4,
      'Fan': 113.76,
    },
    'May': {
      'AC': 478.8,
      'Light': 193.6,
      'Fan': 119.88,
    },
    'Jun': {
      'AC': 506.4,
      'Light': 205.8,
      'Fan': 126,
    },
    'Jul': {
      'AC': 532,
      'Light': 211,
      'Fan': 135.12,
    },
    'Aug': {
      'AC': 562.6,
      'Light': 220.2,
      'Fan': 140.24,
    },
    'Sep': {
      'AC': 588.2,
      'Light': 229.4,
      'Fan': 146.36,
    },
    'Oct': {
      'AC': 616.8,
      'Light': 238.6,
      'Fan': 153.48,
    },
    'Nov': {
      'AC': 643.4,
      'Light': 251.8,
      'Fan': 160.6,
    },
    'Dec': {
      'AC': 672,
      'Light': 259,
      'Fan': 166.72,
    },
  };

  // Data for comparison line chart
  List<Map<String, dynamic>> _comparisonData = [
    {'month': 'Mar', 'before': 441.6, 'after': 424.6},
    {'month': 'Apr', 'before': 469.2, 'after': 453.2},
    {'month': 'May', 'before': 496.8, 'after': 478.8},
    {'month': 'Jun', 'before': 524.4, 'after': 506.4},
    {'month': 'Jul', 'before': 552, 'after': 532},
    {'month': 'Aug', 'before': 579.6, 'after': 562.6},
    {'month': 'Sep', 'before': 607.2, 'after': 588.2},
    {'month': 'Oct', 'before': 634.8, 'after': 616.8},
    {'month': 'Nov', 'before': 662.4, 'after': 643.4},
    {'month': 'Dec', 'before': 690, 'after': 672},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Nest'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedMonth,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedMonth = newValue!;
                });
              },
              items: _monthlyDataBefore.keys.map<DropdownMenuItem<String>>((String month) {
                return DropdownMenuItem<String>(
                  value: month,
                  child: Text(month),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: 160,
                  height: 160,
                  child: PieChart(
                    PieChartData(
                      sections: _monthlyDataBefore[_selectedMonth]!.entries
                          .map((entry) => PieChartSectionData(
                        value: entry.value,
                        title: '${entry.key}: ${entry.value}',
                        radius: 80,
                        titleStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        color: Colors.primaries[_monthlyDataBefore[_selectedMonth]!.keys
                            .toList()
                            .indexOf(entry.key) %
                            Colors.primaries.length],
                      ))
                          .toList(),
                    ),
                  ),
                ),
                SizedBox(
                  width: 160,
                  height: 160,
                  child: PieChart(
                    PieChartData(
                      sections: _monthlyDataAfter[_selectedMonth]!.entries
                          .map((entry) => PieChartSectionData(
                        value: entry.value,
                        title: '${entry.key}: ${entry.value}',
                        radius: 80,
                        titleStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        color: Colors.primaries[_monthlyDataAfter[_selectedMonth]!.keys
                            .toList()
                            .indexOf(entry.key) %
                            Colors.primaries.length],
                      ))
                          .toList(),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            SizedBox(
              width: 370,
              height: 300, // Adjusted height for the line graph
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                      spots: _comparisonData
                          .map((data) => FlSpot(
                          _comparisonData.indexOf(data).toDouble(),
                          data['before'].toDouble()))
                          .toList(),
                      isCurved: true,
                      barWidth: 2,
                      color: Colors.blue,
                    ),
                    LineChartBarData(
                      spots: _comparisonData
                          .map((data) => FlSpot(
                          _comparisonData.indexOf(data).toDouble(),
                          data['after'].toDouble()))
                          .toList(),
                      isCurved: true,
                      barWidth: 2,
                      color: Colors.red,
                    ),
                  ],
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            _comparisonData[value.toInt()]['month'],
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  gridData: FlGridData(show: true),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
