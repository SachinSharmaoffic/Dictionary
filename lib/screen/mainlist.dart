import 'package:flutter/material.dart';

class mainlist extends StatelessWidget {
  final String item;
  final String def;
  const mainlist({super.key, required this.item, required this.def});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(
              Icons.fiber_manual_record,
              size: 12,
            ),
            // Padding(
            // padding: const EdgeInsets.all(8.0),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    item,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 250,
                    child: Text(
                      "To deliberately make something unclear or difficult to understand.",
                      style: TextStyle(color: Color.fromARGB(221, 56, 55, 55)),
                    ),
                  ),
                ],
                // ),
              ),
            ),
            Spacer(),
            Icon(
              Icons.star_border,
              size: 35,
              color: Color.fromRGBO(170, 170, 170, 1),
            ),
          ],
        ),
      ),
    );
  }
}
