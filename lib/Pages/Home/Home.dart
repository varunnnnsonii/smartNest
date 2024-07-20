import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
    'Living Room': 'assets/icons/living-room.gif',
    'Room': 'assets/icons/WhatsApp Image 2024-07-20 at 18.27.27_84a553a2.jpg',
    'Kitchen': 'assets/icons/stir.gif',
    'Bedroom': 'assets/icons/sleep.gif',
    'Passage': 'assets/icons/WhatsApp Image 2024-07-20 at 18.27.17_ceb4c461.jpg',
    'Balcony': 'assets/icons/balcony (1).png',
    'Storeroom': 'assets/icons/WhatsApp Image 2024-07-20 at 18.27.22_a7e0bd58.jpg',
  };

  final Map<String, Color> roomColors = {
    'Living Room': Colors.blueAccent,
    'Room': Colors.greenAccent,
    'Kitchen': Colors.redAccent,
    'Bedroom': Colors.purpleAccent,
    'Passage': Colors.orangeAccent,
    'Gallery': Colors.tealAccent,
    'Storeroom': Colors.brown,
  };

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.75, // Height greater than width
              ),
              delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
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
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: isNetworkImage
                                ? CachedNetworkImage(
                              imageUrl: imagePath,
                              height: 100.0,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            )
                                : Image.asset(
                              imagePath,
                              height: 100.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Spacer(),
                          Text(
                            roomName,
                            style: TextStyle(
                              fontSize: 16.0,
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
                childCount: FloorPlan.rooms.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
