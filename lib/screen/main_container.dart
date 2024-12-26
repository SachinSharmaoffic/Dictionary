import 'package:dictionary/screen/mainlist.dart';
import 'package:flutter/material.dart';

class MainContainer extends StatelessWidget {
  const MainContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(60.0),
          ),
          color: Colors.white,
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Recent Search",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Expanded(child: Center()),
                  Text(
                    "Check History",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Card(
                elevation: 15,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(230, 234, 240, 1),
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    children: [
                      mainlist(
                          item: 'Obfuscate',
                          def:
                              'To deliberately make something unclear or difficult to understand.'),
                    ],
                  ),
                ),
              ),
              Image.asset('assets/images/ok2.png')
            ],
          ),
        ),
      ),
    );
  }
}
