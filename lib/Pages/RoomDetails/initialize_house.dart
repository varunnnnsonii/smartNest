import 'package:flutter/material.dart';
import 'package:fluttercuredoc/Compo/ElevatedButton.dart';
import 'package:fluttercuredoc/WIDGETS/floor_plan.dart';
import '../../Navbar/nav_menu.dart';

class InitilizePage extends StatefulWidget {
  const InitilizePage({super.key});

  @override
  State<InitilizePage> createState() => _InitilizePageState();
}

class _InitilizePageState extends State<InitilizePage> {
  List<TextEditingController> _controllers = [TextEditingController()];

  void _addTextField() {
    setState(() {
      _controllers.add(TextEditingController());
    });
  }

  void _showUsernameDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text("Enter Usernames"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ..._controllers.map((controller) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          labelText: "Username",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    );
                  }).toList(),
                  ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _addTextField();
                      });
                    },
                    icon: Icon(Icons.add),
                    label: Text("Add Username"),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    List<String> usernames = _controllers
                        .map((controller) => controller.text)
                        .where((username) => username.isNotEmpty)
                        .toList();
                    print("Usernames: ${usernames.join(', ')}");
                    Navigator.of(context).pop();
                  },
                  child: Text("Submit"),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text("Cancel"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Smart Nest",
          style: TextStyle(fontSize: 27, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showUsernameDialog,
          ),
        ],
      ),
      body: Column(
        children: [
          FloorPlan(),
          CustomElevatedButton(
            title: "Submit",
            color1: Colors.blueAccent.shade100,
            color2: Colors.blueAccent,
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => NavigationMenu()),
                    (Route<dynamic> route) => false,
              );
            },
            padh: 110,
            padv: 20,
          ),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
