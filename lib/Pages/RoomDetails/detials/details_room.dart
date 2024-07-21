import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final Map<String, dynamic> roomDetails;

  const DetailsScreen({Key? key, required this.roomDetails}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late Map<String, List<bool>> applianceStates;

  @override
  void initState() {
    super.initState();
    final appliances = widget.roomDetails['appliances'] as Map<String, int>;
    applianceStates = appliances.map((appliance, quantity) {
      return MapEntry(appliance, List<bool>.filled(quantity, false));
    });
  }

  @override
  Widget build(BuildContext context) {
    final roomName = widget.roomDetails['roomName'];
    final appliances = widget.roomDetails['appliances'] as Map<String, int>;

    List<Widget> gridItems = [];

    appliances.forEach((applianceName, quantity) {
      final states = applianceStates[applianceName]!;

      List<Widget> items = [];
      for (int i = 0; i < quantity; i++) {
        final isActive = states[i];

        items.add(
          Container(
            decoration: BoxDecoration(
              color: isActive ? Colors.green.shade100 : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (applianceName == 'Light')
                  IconButton(
                    icon: Icon(
                      isActive ? Icons.lightbulb : Icons.lightbulb_outline,
                      color: isActive ? Colors.yellow : Colors.black,
                      size: 50.0,
                    ),
                    onPressed: () {
                      setState(() {
                        states[i] = !states[i];
                      });
                    },
                  )
                else
                  Switch(
                    value: isActive,
                    onChanged: (bool value) {
                      setState(() {
                        states[i] = value;
                      });
                    },
                    activeColor: Colors.blueAccent,
                  ),
      SizedBox(height: 20,),
      Text(
      '$applianceName ${i + 1}',
      style: TextStyle(
      color: isActive ? Colors.blueAccent.shade700 : Colors.black,
      fontWeight: FontWeight.bold,fontSize: 17
      ),
      ),
              ],
            ),
          ),
        );
      }

      gridItems.add(
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                applianceName,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            Container(
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 1.0,
                ),
                itemCount: quantity,
                itemBuilder: (context, index) => items[index],
              ),
            ),
          ],
        ),
      );
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(roomName),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: gridItems,
      ),
    );
  }
}
