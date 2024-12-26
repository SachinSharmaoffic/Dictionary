import 'dart:convert';

import 'package:dictionary/api.dart';
import 'package:dictionary/screen/RESULT_PAGES/example.dart';
import 'package:dictionary/screen/RESULT_PAGES/defination.dart';
import 'package:dictionary/screen/RESULT_PAGES/synonym.dart';
import 'package:dictionary/screen/mainlist.dart';
import 'package:http/http.dart' as http;
import 'package:dictionary/screen/widjets/chips.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  final String word;

  const ResultPage({Key? key, required this.word}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late Future<WordDetails> _wordDetails;

  @override
  void initState() {
    super.initState();
    _wordDetails = fetchWordDetails();
  }

  Future<WordDetails> fetchWordDetails() async {
    final response = await http.get(Uri.parse(
        'https://api.dictionaryapi.dev/api/v2/entries/en/${widget.word}'));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> wordDetailsData = responseData[0];
      return WordDetails.fromJson(wordDetailsData);
    } else {
      throw Exception('Failed to load data');
    }
  }

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
            fontFamily: 'Lora',
          ),
        ),
      ),
      body: FutureBuilder<WordDetails>(
        future: _wordDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return Text('No data found.');
          }
          final WordDetails wordDetails = snapshot.data!;
          print(wordDetails.meanings.length);

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      wordDetails.word,
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontFamily: "lora",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (wordDetails.phonetics.isNotEmpty)
                      Text(
                        wordDetails.phonetics[1]['text'] ?? "",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(232, 249, 224, 224),
                        ),
                      ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        dabba(data: "Listen", icon: Icons.volume_up_outlined),
                        dabba(data: "Save", icon: Icons.star_border_outlined),
                        dabba(data: "Copy", icon: Icons.copy),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  //                   border: OutlineInputBorder(
                  //   borderSide: BorderSide(color: Colors.white),
                  //   borderRadius: BorderRadius.circular(50),
                  // ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(60.0),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.abc_outlined,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Word Meaning",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: wordDetails.meanings.length + 1,
                          itemBuilder: (context, index) {
                            List<Color> colors = [
                              Color.fromRGBO(235, 248, 255, 1),
                              Color.fromRGBO(252, 241, 237, 1),
                              Color.fromRGBO(238, 250, 236, 1),
                            ];
                            List<Color> colors2 = [
                              Color.fromRGBO(175, 226, 255, 1),
                              Color.fromRGBO(255, 219, 211, 1),
                              Color.fromRGBO(207, 246, 167, 1),

                              // Add more colors as needed
                            ];
                            if (index == 0) {
                              return resMain1(wordDetails: wordDetails);
                            } else {
                              final meaning = wordDetails.meanings[index - 1];
                              final Color mainColor =
                                  colors[index % colors.length];
                              final Color mainColor2 =
                                  colors2[index % colors2.length];
                              return resMain2(
                                meanings: meaning,
                                main: mainColor,
                                main2: mainColor2,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
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
