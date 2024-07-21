import 'package:flutter/material.dart';

class ApplianceDetailsPage extends StatefulWidget {
  final Map<String, dynamic> room;

  const ApplianceDetailsPage({super.key, required this.room});

  @override
  _ApplianceDetailsPageState createState() => _ApplianceDetailsPageState();
}

class _ApplianceDetailsPageState extends State<ApplianceDetailsPage> {
  final Map<String, Map<int, double>> _applianceTimesStart = {};
  final Map<String, Map<int, double>> _applianceTimesEnd = {};
  final Map<String, Map<int, double>> _applianceTemperatures = {};
  final Map<String, Map<int, bool>> _applianceStates = {};
  final Map<String, Map<int, String>> _finalizedTimes = {};

  @override
  void initState() {
    super.initState();
    // Initialize times and states
    widget.room['appliances'].forEach((key, value) {
      if (value > 0) {
        for (int i = 0; i < value; i++) {
          _applianceTimesStart.putIfAbsent(key, () => {});
          _applianceTimesEnd.putIfAbsent(key, () => {});
          _applianceStates.putIfAbsent(key, () => {});
          _finalizedTimes.putIfAbsent(key, () => {});

          _applianceTimesStart[key]![i] = 0.0; // Default start time
          _applianceTimesEnd[key]![i] = 1.0;   // Default end time
          _applianceStates[key]![i] = true;    // Default On/Off state

          if (key == 'AC') {
            _applianceTemperatures.putIfAbsent(key, () => {});
            _applianceTemperatures[key]![i] = 25.0; // Default temperature for AC
          }
          if (key == 'Oven') {
            _applianceTemperatures.putIfAbsent(key, () => {});
            _applianceTemperatures[key]![i] = 0.0; // Default temperature for Oven
          }
        }
      }
    });
  }

  String _formatTime(double timeInHours) {
    int hours = timeInHours.toInt();
    int minutes = ((timeInHours - hours) * 60).toInt();
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }

  void _finalizeTime(String appliance, int index) {
    final startTime = _formatTime(_applianceTimesStart[appliance]?[index] ?? 0.0);
    final endTime = _formatTime(_applianceTimesEnd[appliance]?[index] ?? 1.0);
    String message;

    if (_applianceStates[appliance]?[index] == false) {
      message = 'At time $startTime - $endTime the device will be off';
    } else {
      if (appliance == 'AC' || appliance == 'Oven') {
        final temperature = _applianceTemperatures[appliance]?[index] ?? 0.0;
        message = 'At time $startTime - $endTime the device will be at $temperature°C';
      } else {
        message = 'At time $startTime - $endTime the device will be on';
      }
    }

    setState(() {
      _finalizedTimes[appliance]![index] = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    final room = widget.room;
    return Scaffold(
      appBar: AppBar(
        title: Text('${room['roomName']} Appliances'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: room['appliances'].entries.expand<Widget>((entry) {
          final appliance = entry.key;
          final count = entry.value;
          List<Widget> widgets = [];

          for (int i = 0; i < count; i++) {
            widgets.add(
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent.shade100,
                  borderRadius: BorderRadius.circular(30),
                ), // Background color for each list item
                padding: EdgeInsets.all(16.0),
                margin: EdgeInsets.only(bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$appliance ${i + 1}',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'On/Off',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                        Switch(
                          value: _applianceStates[appliance]?[i] ?? false,
                          onChanged: (bool value) {
                            setState(() {
                              _applianceStates[appliance]![i] = value;
                            });
                          },
                        ),
                      ],
                    ),
                    if (appliance == 'Oven') ...[
                      DropdownButton<double>(
                        value: _applianceTemperatures[appliance]?[i] ?? 0.0,
                        onChanged: (double? newValue) {
                          setState(() {
                            if (newValue != null) {
                              _applianceTemperatures[appliance]![i] = newValue;
                            }
                          });
                        },
                        items: List.generate(
                          41,
                              (index) => DropdownMenuItem<double>(
                            value: index.toDouble(),
                            child: Text('${index.toDouble()}°C'),
                          ),
                        ),
                      ),
                    ],
                    if (appliance == 'AC') ...[
                      DropdownButton<double>(
                        value: _applianceTemperatures[appliance]?[i] ?? 25.0,
                        onChanged: (double? newValue) {
                          setState(() {
                            if (newValue != null) {
                              _applianceTemperatures[appliance]![i] = newValue;
                            }
                          });
                        },
                        items: List.generate(
                          12,
                              (index) => DropdownMenuItem<double>(
                            value: 18.0 + index.toDouble(),
                            child: Text('${18.0 + index.toDouble()}°C'),
                          ),
                        ),
                      ),
                    ],
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Time Range:',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    RangeSlider(
                      min: 0.0,
                      max: 24.0,
                      divisions: 24 * 2, // Divide into 48 intervals for minutes
                      values: RangeValues(
                        _applianceTimesStart[appliance]?[i] ?? 0.0,
                        _applianceTimesEnd[appliance]?[i] ?? 1.0,
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _applianceTimesStart[appliance]![i] = values.start;
                          _applianceTimesEnd[appliance]![i] = values.end;
                        });
                      },
                    ),
                    Row(
                      children: [
                        Text(
                          '${_formatTime(_applianceTimesStart[appliance]?[i] ?? 0.0)} - ${_formatTime(_applianceTimesEnd[appliance]?[i] ?? 1.0)}',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            _finalizeTime(appliance, i);
                          },
                          child: Text('Finalize',style: TextStyle(color: Colors.blue),),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    // Display finalized message below the button
                    if (_finalizedTimes[appliance]?.containsKey(i) ?? false) ...[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ), // Background color for finalized message
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          _finalizedTimes[appliance]?[i] ?? '',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                    SizedBox(height: 5),
                  ],
                ),
              ),
            );
          }

          return widgets;
        }).toList(),
      ),
    );
  }
}
