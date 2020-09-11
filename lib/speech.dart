import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as sp;

class Speech extends StatefulWidget {
  @override
  _SpeechState createState() => _SpeechState();
}

class _SpeechState extends State<Speech> {
  final Map<String, HighlightedWord> _highlights = {
    'safi': HighlightedWord(
      onTap: () => print('Safi'),
      textStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    ),
    'ammar': HighlightedWord(
      onTap: () => print('Ammar'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
    'taimoor': HighlightedWord(
      onTap: () => print('Taimoor'),
      textStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    'hamza': HighlightedWord(
      onTap: () => print('Hamza'),
      textStyle: const TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ),
    ),
    'rubbri': HighlightedWord(
      onTap: () => print('Rubbri'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
    'kinza': HighlightedWord(
      onTap: () => print('Pink'),
      textStyle: const TextStyle(
        color: Colors.pink,
        fontWeight: FontWeight.bold,
      ),
    ),
    'urooj': HighlightedWord(
      onTap: () => print('Urooj'),
      textStyle: const TextStyle(
        color: Colors.brown,
        fontWeight: FontWeight.bold,
      ),
    ),
    'rumsha': HighlightedWord(
      onTap: () => print('Rumsha'),
      textStyle: const TextStyle(
        color: Colors.deepOrangeAccent,
        fontWeight: FontWeight.bold,
      ),
    ),
    'like': HighlightedWord(
      onTap: () => print('Like'),
      textStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    ),
    'github': HighlightedWord(
      onTap: () => print('Github'),
      textStyle: const TextStyle(
        color: Colors.black26,
        fontWeight: FontWeight.bold,
      ),
    ),
    'start': HighlightedWord(
      onTap: () => print('Start'),
      textStyle: const TextStyle(
        color: Colors.yellow,
        fontWeight: FontWeight.bold,
      ),
    ),
  };
  sp.SpeechToText _speech;
  bool _isListening=false;
  String _text="Say some thing";
  double _confidence=1.0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   _speech= sp.SpeechToText();
  }

  void _listen()async {
        if(!_isListening){
          bool available=await _speech.initialize(onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),);
        if(available){
          setState(() {
            _isListening=true;
          });
          _speech.listen(
            onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
              
            
          );
        }
        }
        else{
          setState(() {
            _isListening=false;
            _speech.stop();
          });
        }
        
      }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Confidence level: ${(_confidence*100).toStringAsFixed(1)}"),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,

        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
              child: FloatingActionButton(onPressed:_listen ,
        child: Icon(_isListening? Icons.mic:Icons.mic_none),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
          child: TextHighlight(
            text: _text,
            words: _highlights,
            textStyle: const TextStyle(
              fontSize: 32.0,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
          );

   
      
       
  }
}