import 'package:dictionary/screen/RESULT_PAGES/result.dart';
import 'package:dictionary/screen/main_container.dart';
import 'package:dictionary/screen/mainlist.dart';

import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _controller = TextEditingController();

  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(212, 51, 76, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(212, 51, 76, 1),
        title: Text(
          "Dictionary",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Lora'),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                filled: true,
                hintText: "Search for word",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(Icons.search),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _controller.clear();
                      });
                    },
                    child: Icon(Icons.close),
                  ),
                ),
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black, // Text color
                fontWeight:
                    FontWeight.normal, // Text weight (e.g., bold, normal)
                fontStyle: FontStyle.normal, // Text style (e.g., italic)
                // Customize other text style properties as needed
              ),
              // Additional properties for handling input and validation can be added here
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ResultPage(
                              word: _controller.text,
                            )));
              },
              child: Text(
                'Search',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.amber,

                // Set the background color here
              ),
            ),
          ),
          MainContainer(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Color.fromRGBO(76, 116, 176, 1),
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        selectedItemColor: Color.fromRGBO(212, 51, 76, 1),
        unselectedItemColor: Color.fromARGB(221, 56, 55, 55),
        selectedFontSize: 14,
        backgroundColor: Colors.blue,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
