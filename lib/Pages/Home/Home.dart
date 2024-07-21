import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttercuredoc/Profile/EditProfile.dart';
import 'package:fluttercuredoc/Profile/Profile.dart';
import 'package:fluttercuredoc/WIDGETS/in_out.dart';
import 'package:fluttercuredoc/WIDGETS/short_noti.dart';
import 'package:get/get.dart';
import 'package:fluttercuredoc/Compo/user_controller.dart';
import 'package:fluttercuredoc/Pages/RoomDetails/detials/details_room.dart';
import 'package:fluttercuredoc/WIDGETS/floor_plan.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, this.isNetworkImage = false}) : super(key: key);
  final bool isNetworkImage;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
    final controller = Get.put(UserController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text("Smart Nest"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: 350,
              child: Column(
                children: [
                  Container(
                    height:130,
                    child: ShortNoti(),
                  ),
                  Container(
                    height:160,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 0.0,top: 30),
                      child: InorOut(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                  Text("Rooms", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
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
                  final isNetworkImage = widget.isNetworkImage;

                  return GestureDetector(
                    onTap: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(roomDetails: room),
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
                              child: isNetworkImage
                                  ? CachedNetworkImage(
                                imageUrl: imagePath,
                                height: 100.0,
                                width: 100.0,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  height: 50.0,
                                  width: 50.0,
                                  alignment: Alignment.center,
                                  child: CircularProgressIndicator(),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  height: 100.0,
                                  width: 100.0,
                                  alignment: Alignment.center,
                                  child: Icon(Icons.error, color: Colors.red),
                                ),
                              )
                                  : Image.asset(
                                imagePath,
                                height: 80.0,
                                width: 70.0,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
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
      ),
    );
  }
}
