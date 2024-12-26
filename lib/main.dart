import 'package:dictionary/screen/search.dart';
import 'package:dictionary/screen/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MydictApp());
}

class MydictApp extends StatelessWidget {
  const MydictApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/search': (context) => const Search(),
      },
      home: Splash(),
    );
  }
}
