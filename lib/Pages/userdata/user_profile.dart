import 'package:flutter/material.dart';
import 'package:fluttercuredoc/WIDGETS/floor_plan.dart';

import '../../Navbar/nav_menu.dart';
import 'people_add_widget.dart';

class userprofile extends StatefulWidget {
  const userprofile({super.key});

  @override
  State<userprofile> createState() => _UserprofileState();
}

class _UserprofileState extends State<userprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Add Relations",
          style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.w600
          ),
        ),
      ),
      body: Column(
        children: [
          PeopleWidgets(),
          ElevatedButton(
            onPressed: () {},
            child: Text("Submit"),
          ),

          SizedBox(height: 30,)
        ],
      ),
    );
  }
}
