import 'package:flutter/material.dart';

class FloorPlan extends StatefulWidget {
  static List<Map<String, dynamic>> rooms = [];

  const FloorPlan({super.key});

  @override
  _FloorPlanState createState() => _FloorPlanState();
}

class _FloorPlanState extends State<FloorPlan> {
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
              backgroundColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.edit, color: Colors.blue, size: 24),
                  SizedBox(width: 8),
                  Text('Add Room', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButton<String>(
                      value: _selectedRoomType,
                      hint: Text('Select Room Type', style: TextStyle(color: Colors.black54)),
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
                          child: Text(value, style: TextStyle(color: Colors.black)),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 16),
                    ...appliances.keys.map((appliance) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(appliance, style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w500,fontSize: 18)),
                              Switch(
                                value: appliances[appliance]! > 0,
                                activeColor: Colors.blue,
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
                                  icon: Icon(Icons.remove, color: Colors.blue),
                                  onPressed: () {
                                    setStateDialog(() {
                                      if (appliances[appliance]! > 0) {
                                        appliances[appliance] = appliances[appliance]! - 1;
                                      }
                                    });
                                  },
                                ),
                                Text(appliances[appliance].toString(), style: TextStyle(color: Colors.black,fontSize: 19)),
                                IconButton(
                                  icon: Icon(Icons.add, color: Colors.blue),
                                  onPressed: () {
                                    setStateDialog(() {
                                      appliances[appliance] = appliances[appliance]! + 1;
                                    });
                                  },
                                ),
                              ],
                            ),
                          SizedBox(height: 8),
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
                  child: Text('Cancel', style: TextStyle(color: Colors.grey,fontSize: 18)),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_selectedRoomType != null) {
                      setState(() {
                        final roomDetails = {
                          'roomName': _selectedRoomType,
                          'appliances': Map<String, int>.from(appliances)
                            ..removeWhere((key, value) => value == 0),
                        };
                        FloorPlan.rooms.add(roomDetails);
                        _selectedRoomType = null;
                        appliances.updateAll((key, value) => 0);
                      });
                      Navigator.of(context).pop();
                      // Placeholder function to store data to a database
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Set the background color to blue
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )

              ],
            );
          },
        );
      },
    );
  }

  void _deleteRoom(int index) {
    setState(() {
      FloorPlan.rooms.removeAt(index);
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
            SizedBox(height: 40,),
            Expanded(
              child: FloorPlan.rooms.isEmpty
                  ?  Center(child: Image.asset("assets/images/download-removebg-preview.png"))
                  : ListView.builder(
                itemCount: FloorPlan.rooms.length,
                itemBuilder: (context, index) {
                  final room = FloorPlan.rooms[index];
                  return Card(
                    margin: EdgeInsets.only(top: 20),
                    color: Colors.white,
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(10),
                      leading: Text(
                        room['roomName'],
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: room['appliances'].entries.map<Widget>((entry) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                            child: Text(
                              '${entry.key}: ${entry.value}',
                              style: TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.blue),
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
