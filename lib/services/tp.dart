// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:uuid/uuid.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('House Management'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () async {
//                 await addHouseData();
//                 print("House data added");
//               },
//               child: Text('Add House Data'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 // Use the actual houseId from your added data
//                 String houseId = 'YOUR_HOUSE_ID_HERE';
//                 await getHouseData(houseId);
//               },
//               child: Text('Get House Data'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// Future<void> addHouseData() async {
//   var uuid = Uuid();
//   String houseId;
//   bool houseIdExists = true;
//
//   // Generate a unique house ID
//   while (houseIdExists) {
//     houseId = uuid.v4();
//     DocumentSnapshot doc = await FirebaseFirestore.instance.collection('house').doc(houseId).get();
//     houseIdExists = doc.exists;
//   }
//
//   // House data example
//   Map<String, dynamic> houseData = {
//     'adminId': 'varun271203@gmail.com',
//     'members': ['sharib@gmail.com', 'pritesh@gmail.com', 'anaum@gmail.com'],
//     'rooms': {
//       'living room': {
//         'fan1': 0,
//         'fan2': 100,
//         'light1': 100,
//         'ac1': 36,
//       },
//     },
//   };
//
//   // Add the house data to Firestore
//   await FirebaseFirestore.instance.collection('house').doc(houseId).set(houseData);
// }
//
// Future<void> getHouseData(String houseId) async {
//   DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('house').doc(houseId).get();
//
//   if (documentSnapshot.exists) {
//     Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
//     print("House ID: $houseId");
//     print("Admin ID: ${data['adminId']}");
//     print("Members: ${data['members']}");
//     print("Rooms: ${data['rooms']}");
//   } else {
//     print("No house found with ID $houseId");
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(tpapp());
}

class tpapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  String adminId = '';
  List<String> members = [];
  List<Map<String, dynamic>> rooms = [];

  TextEditingController adminIdController = TextEditingController();
  List<TextEditingController> memberControllers = [];
  List<Map<String, List<TextEditingController>>> roomControllers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('House Management'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: adminIdController,
                decoration: InputDecoration(labelText: 'Admin ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter admin ID';
                  }
                  return null;
                },
              ),
              ..._buildMemberFields(),
              ..._buildRoomFields(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      adminId = adminIdController.text;
                      members = memberControllers.map((controller) => controller.text).toList();
                      rooms = roomControllers.map((room) {
                        return {
                          'roomType': room['roomType']![0].text,
                          'appliances': {
                            for (var i = 0; i < room['applianceName']!.length; i++)
                              room['applianceName']![i].text: int.parse(room['applianceStatus']![i].text)
                          }
                        };
                      }).toList();
                    });

                    addHouseData();
                  }
                },
                child: Text('Add House Data'),
              ),
              ElevatedButton(
                onPressed: () async {
                  // Use the actual houseId from your added data
                  String houseId = 'YOUR_HOUSE_ID_HERE';
                  await getHouseData(houseId);
                },
                child: Text('Get House Data'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    memberControllers.add(TextEditingController());
                  });
                },
                child: Text('Add Member'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    roomControllers.add({
                      'roomType': [TextEditingController()],
                      'applianceName': [TextEditingController()],
                      'applianceStatus': [TextEditingController()],
                    });
                  });
                },
                child: Text('Add Room'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildMemberFields() {
    return memberControllers
        .asMap()
        .entries
        .map((entry) => TextFormField(
      controller: entry.value,
      decoration: InputDecoration(labelText: 'Member ${entry.key + 1}'),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter member email';
        }
        return null;
      },
    ))
        .toList();
  }

  List<Widget> _buildRoomFields() {
    return roomControllers
        .asMap()
        .entries
        .map((entry) {
      int roomIndex = entry.key;
      var room = entry.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: room['roomType']![0],
            decoration: InputDecoration(labelText: 'Room Type ${roomIndex + 1}'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter room type';
              }
              return null;
            },
          ),
          ...room['applianceName']!
              .asMap()
              .entries
              .map((applianceEntry) {
            int applianceIndex = applianceEntry.key;
            return Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: applianceEntry.value,
                    decoration: InputDecoration(labelText: 'Appliance ${applianceIndex + 1} Name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter appliance name';
                      }
                      return null;
                    },
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: room['applianceStatus']![applianceIndex],
                    decoration: InputDecoration(labelText: 'Appliance ${applianceIndex + 1} Status'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter appliance status';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            );
          })
              .toList(),
          ElevatedButton(
            onPressed: () {
              setState(() {
                room['applianceName']!.add(TextEditingController());
                room['applianceStatus']!.add(TextEditingController());
              });
            },
            child: Text('Add Appliance'),
          ),
        ],
      );
    })
        .toList();
  }

  Future<void> addHouseData() async {
    var uuid = Uuid();
    String houseId = uuid.v4();
    bool houseIdExists = true;

    // Generate a unique house ID
    while (houseIdExists) {
      DocumentSnapshot doc = await FirebaseFirestore.instance.collection('house').doc(houseId).get();
      houseIdExists = doc.exists;
      if (houseIdExists) {
        houseId = uuid.v4(); // Regenerate if the ID exists
      }
    }

    // House data example
    Map<String, dynamic> houseData = {
      'adminId': adminId,
      'members': members,
      'rooms': {
        for (var room in rooms) room['roomType']: room['appliances'],
      },
    };

    // Add the house data to Firestore
    await FirebaseFirestore.instance.collection('house').doc(houseId).set(houseData);
  }

  Future<void> getHouseData(String houseId) async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('house').doc(houseId).get();

    if (documentSnapshot.exists) {
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      print("House ID: $houseId");
      print("Admin ID: ${data['adminId']}");
      print("Members: ${data['members']}");
      print("Rooms: ${data['rooms']}");
    } else {
      print("No house found with ID $houseId");
    }
  }
}
