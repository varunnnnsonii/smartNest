import 'package:flutter/material.dart';

class PeopleWidgets extends StatefulWidget {
  static List<Map<String, dynamic>> rooms = [];

  const PeopleWidgets({super.key});

  @override
  _PeopleWidgetsState createState() => _PeopleWidgetsState();
}

class _PeopleWidgetsState extends State<PeopleWidgets> {
  final Map<String, int> appliances = {
    'AC': 0,
    'Light': 0,
    'Oven': 0,
    'Fan': 0,
    'Exhaust Fan': 0,
    'Washing Machine': 0,
  };

  String? _selectedRoomType;

  @override
  void dispose() {
    super.dispose();
  }

  void _showAddPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: const Text('Add Room'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    DropdownButton<String>(
                      value: _selectedRoomType,
                      hint: const Text('Select Room Type'),
                      onChanged: (String? newValue) {
                        setStateDialog(() {
                          _selectedRoomType = newValue;
                        });
                      },
                      items: <String>[
                        'Living Room',
                        'Room',
                        'Kitchen',
                        'Bedroom',
                        'Passage',
                        'Balcony',
                        'Storeroom'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    ...appliances.keys.map((appliance) {
                      return Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(appliance),
                              Switch(
                                value: appliances[appliance]! > 0,
                                onChanged: (value) {
                                  setStateDialog(() {
                                    appliances[appliance] = value ? 1 : 0;
                                  });
                                },
                              ),
                            ],
                          ),
                          if (appliances[appliance]! > 0)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    setStateDialog(() {
                                      if (appliances[appliance]! > 0) {
                                        appliances[appliance] = appliances[appliance]! - 1;
                                      }
                                    });
                                  },
                                ),
                                Text(appliances[appliance].toString()),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    setStateDialog(() {
                                      appliances[appliance] = appliances[appliance]! + 1;
                                    });
                                  },
                                ),
                              ],
                            ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _selectedRoomType = null;
                    appliances.updateAll((key, value) => 0);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (_selectedRoomType != null) {
                      setState(() {
                        final roomDetails = {
                          'roomName': _selectedRoomType,
                          'appliances': Map<String, int>.from(appliances)
                            ..removeWhere((key, value) => value == 0),
                        };
                        PeopleWidgets.rooms.add(roomDetails);
                        _selectedRoomType = null;
                        appliances.updateAll((key, value) => 0);
                      });
                      Navigator.of(context).pop();
                      // Placeholder function to store data to a database
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _deleteRoom(int index) {
    setState(() {
      PeopleWidgets.rooms.removeAt(index);
    });
  }

  void _storeToDatabase(Map<String, dynamic> roomDetails) {
    // Implement your database storage logic here
    print('Storing to database: $roomDetails');
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: _showAddPopup,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                elevation: 5,
                shape: CircleBorder(),
                padding: EdgeInsets.all(15),
              ),
              child: Icon(
                Icons.add,
                size: 50,
                color: Colors.white,
              ),
            ),

            Expanded(
              child: PeopleWidgets.rooms.isEmpty
                  ?  Center(child: Image.asset("assets/images/download-removebg-preview.png"))
                  : ListView.builder(
                itemCount: PeopleWidgets.rooms.length,
                itemBuilder: (context, index) {
                  final room = PeopleWidgets.rooms[index];
                  return Card(
                    child: ListTile(
                      leading: Text(room['roomName']),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: room['appliances'].entries.map<Widget>((entry) {
                          return Text('${entry.key}: ${entry.value}');
                        }).toList(),
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => _deleteRoom(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
