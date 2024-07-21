import 'package:flutter/material.dart';

class InorOut extends StatefulWidget {
  const InorOut({super.key});

  @override
  _InorOutState createState() => _InorOutState();
}

class _InorOutState extends State<InorOut> {
  bool isIndoorSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10,),
              Text("Activity",style: TextStyle(fontSize: 23,fontWeight: FontWeight.w500),),

              SizedBox(height: 20,),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildButton(
                        icon: Icons.home,
                        text: 'Indoor',
                        isSelected: isIndoorSelected,
                        onTap: () {
                          setState(() {
                            isIndoorSelected = true;
                          });
                        },
                      ),
                      const SizedBox(width: 30),
                      _buildButton(
                        icon: Icons.directions_walk,
                        text: 'Outdoor',
                        isSelected: !isIndoorSelected,
                        onTap: () {
                          setState(() {
                            isIndoorSelected = false;
                          });
                        },
                      ),
                    ],
                  ),
              ),
            ],
          ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return isSelected
        ? ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: Colors.white),
      label: Text(text, style: const TextStyle(color: Colors.white)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        side: const BorderSide(color: Colors.blue),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    )
        : OutlinedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, color: Colors.black),
      label: Text(text, style: const TextStyle(color: Colors.black)),
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.black),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: InorOut(),
  ));
}
