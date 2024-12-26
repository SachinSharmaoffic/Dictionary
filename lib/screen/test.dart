import 'dart:convert';
import 'package:dictionary/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResultPage extends StatefulWidget {
  final String word;

  const ResultPage({Key? key, required this.word}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  late Future<WordDetails> _wordDetails;

  @override
  void initState() {
    super.initState();
    _wordDetails = fetchWordDetails();
  }

  Future<WordDetails> fetchWordDetails() async {
    final response = await http.get(
        Uri.parse('https://api.dictionaryapi.dev/api/v2/entries/en/${widget.word}'));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      final Map<String, dynamic> wordDetailsData = responseData[0];
      return WordDetails.fromJson(wordDetailsData);
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dictionary'),
      ),
      body: FutureBuilder<WordDetails>(
        future: _wordDetails,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return Text('No data found.');
          } else {
            final WordDetails wordDetails = snapshot.data!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                          wordDetails.phonetics[0]['text'] ?? "",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(232, 249, 224, 224),
                          ),
                        ),
                      if (wordDetails.phonetics.isNotEmpty)
                        ElevatedButton(
                          onPressed: () {
                            // Play audio (You can implement audio playback logic here)
                          },
                          child: Text("Play Audio"),
                        ),
                      SizedBox(
                        height: 15,
                      ),
                      // Add your other UI components here
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: wordDetails.meanings.length,
                    itemBuilder: (context, index) {
                      final meaning = wordDetails.meanings[index];
                      return ListTile(
                        title: Text(
                          meaning['partOfSpeech'] ?? "",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total Definitions: ${meaning['definitions'].length}",
                              style: TextStyle(fontSize: 16),
                            ),
                            for (var i = 0; i < meaning['definitions'].length; i++)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Definition ${i + 1}: ${meaning['definitions'][i]['definition']}",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  if (meaning['definitions'][i]['example'] != null)
                                    Text(
                                      "Example: ${meaning['definitions'][i]['example']}",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                ],
                              ),
                            Text(
                              "Synonyms: ${meaning['synonyms'].join(', ')}",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              "Antonyms: ${meaning['antonyms'].join(', ')}",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
