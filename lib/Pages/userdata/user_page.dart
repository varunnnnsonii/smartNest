import 'package:flutter/material.dart';
import 'package:fluttercuredoc/Pages/userdata/ApplianceDetailsPage.dart';
import 'package:fluttercuredoc/WIDGETS/floor_plan.dart';

class UserPagess extends StatefulWidget {
  const UserPagess({super.key});

  @override
  State<UserPagess> createState() => _UserPagessState();
}

class _UserPagessState extends State<UserPagess> {
  final Map<String, String> roomImages = {
    'Living Room': 'assets/icons/WhatsApp Image 2024-07-20 at 18.27.17_ceb4c461.jpg',
    'Room': 'assets/icons/WhatsApp Image 2024-07-20 at 18.27.27_84a553a2.jpg',
    'Kitchen': 'assets/icons/WhatsApp Image 2024-07-20 at 18.27.17_ceb4c461.jpg',
    'Bedroom': 'assets/icons/WhatsApp Image 2024-07-20 at 18.27.17_ceb4c461.jpg',
    'Passage': 'assets/icons/WhatsApp Image 2024-07-20 at 18.27.17_ceb4c461.jpg',
    'Balcony': 'assets/icons/balcony (1).png',
    'Storeroom': 'assets/icons/WhatsApp Image 2024-07-20 at 18.27.22_a7e0bd58.jpg',
  };

  final Map<String, Color> roomColors = {
    'Living Room': Colors.lightBlue.shade100,
    'Room': Colors.lightGreen.shade100,
    'Kitchen': Colors.red.shade100,
    'Bedroom': Colors.purple.shade100,
    'Passage': Colors.orange.shade100,
    'Gallery': Colors.teal.shade100,
    'Storeroom': Colors.brown.shade100,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Nest"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // Disable GridView scrolling
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
                childAspectRatio: 0.93, // Height greater than width
              ),
              itemCount: FloorPlan.rooms.length,
              itemBuilder: (BuildContext context, int index) {
                final room = FloorPlan.rooms[index];
                final roomName = room['roomName'];
                final imagePath = roomImages[roomName] ?? 'assets/default.png';
                final bgColor = roomColors[roomName] ?? Colors.grey;

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ApplianceDetailsPage(room: room),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: imagePath.endsWith('.gif')
                              ? Container(
                            height: 100.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Icon(Icons.error, color: Colors.red),
                          )
                              : ClipOval(
                            child: Image.asset(
                              imagePath,
                              height: 100.0,
                              width: 100.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          roomName,
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
