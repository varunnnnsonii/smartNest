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

    return Scaffold(
      appBar: AppBar(
        title: Text(roomName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: appliances.length,
          itemBuilder: (context, index) {
            final applianceName = appliances.keys.elementAt(index);
            final quantity = appliances[applianceName]!;
            final switches = applianceStates[applianceName]!;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '$applianceName',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ...List.generate(quantity, (i) => SwitchListTile(
                  title: Text('$applianceName ${i + 1}'),
                  value: switches[i],
                  onChanged: (bool value) {
                    setState(() {
                      switches[i] = value;
                    });
                  },
                )),
              ],
            );
          },
        ),
      ),
    );
  }
}
