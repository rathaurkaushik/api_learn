import 'package:api_learn/example_five.dart';
import 'package:api_learn/example_four.dart';
import 'package:api_learn/example_three.dart';
import 'package:api_learn/example_tow.dart';
import 'package:api_learn/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: ExampleFive());
  }
}
