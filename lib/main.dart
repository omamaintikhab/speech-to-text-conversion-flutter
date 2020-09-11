import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as sp;
import 'package:speechconversion/speech.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Speech to Text',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Speech(),
    );
  }
}


