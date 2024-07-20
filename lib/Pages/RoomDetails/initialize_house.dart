import 'package:flutter/material.dart';
import 'package:fluttercuredoc/WIDGETS/floor_plan.dart';

import '../../Navbar/nav_menu.dart';

class InitilizePage extends StatefulWidget {
  const InitilizePage({super.key});

  @override
  State<InitilizePage> createState() => _InitilizePageState();
}

class _InitilizePageState extends State<InitilizePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Smart Nest",
        style: TextStyle(
          fontSize: 27,
          fontWeight: FontWeight.w600
        ),
        ),
      ),
      body: Column(
        children: [
          FloorPlan(),
          ElevatedButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => NavigationMenu()),
                    (Route<dynamic> route) => false,
              );
            },
            child: Text("Submit"),
          ),

          SizedBox(height: 30,)
        ],
      ),
    );
  }
}
