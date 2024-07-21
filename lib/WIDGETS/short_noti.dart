import 'package:flutter/material.dart';

class ShortNoti extends StatelessWidget {
  const ShortNoti({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          StatusCard(
            icon: Icons.door_front_door,
            label: 'Front Door',
            status: 'Open',
            color: Colors.blue,
          ),
          StatusCard(
            icon: Icons.lightbulb,
            label: 'Lights',
            status: 'On',
            color: Colors.orange,
          ),
          StatusCard(
            icon: Icons.videocam,
            label: 'Cameras',
            status: 'Off',
            color: Colors.green,
          ),
          StatusCard(
            icon: Icons.wifi,
            label: 'WiFi',
            status: 'On',
            color: Colors.purple,
          ),
        ],
      ),
    );
  }
}

class StatusCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String status;
  final Color color;

  const StatusCard({
    Key? key,
    required this.icon,
    required this.label,
    required this.status,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color.withOpacity(0.1),
            child: Icon(
              icon,
              size: 30,
              color: color,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          Text(
            status,
            style: TextStyle(
              color: status == 'Off' ? Colors.grey : Colors.black,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
