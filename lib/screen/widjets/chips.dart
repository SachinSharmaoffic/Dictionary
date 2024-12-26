import 'package:flutter/material.dart';

class dabba extends StatelessWidget {
  final String data;
  final IconData icon;

  const dabba({super.key, required this.data, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: Color.fromRGBO(177, 29, 52, 1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: Colors.white,
            ),
            Text(
              data,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
