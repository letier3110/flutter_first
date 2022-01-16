import 'dart:html';

import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: VoiceHome());
  }
}

class VoiceHome extends StatefulWidget {
  @override
  State<VoiceHome> createState() => _VoiceHomeState();
}

class _VoiceHomeState extends State<VoiceHome> {
  SpeechRecognition _speechRecognition = SpeechRecognition();
  bool _isAvailable = false;
  bool _isListening = false;

  String resultText = "";

  @override
  void initState() {
    super.initState();
    initSpeechRecognizer();
  }

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();
    _speechRecognition.setAvailabilityHandler(
        (bool result) => setState(() => _isAvailable = result));
    _speechRecognition.setRecognitionStartedHandler(
        () => setState(() => _isListening = true));

    _speechRecognition.setRecognitionResultHandler(
        (String speech) => setState(() => resultText = speech));

    _speechRecognition.setRecognitionCompleteHandler(
        () => setState(() => _isListening = false));

    _speechRecognition
        .activate()
        .then((value) => setState(() => _isAvailable = value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                    mini: true,
                    backgroundColor: Colors.deepOrange,
                    child: Icon(Icons.cancel),
                    onPressed: () {
                      if (_isListening) {
                        _speechRecognition
                            .cancel()
                            .then((value) => setState(() {
                                  _isListening = value;
                                  resultText = "";
                                }));
                      }
                    }),
                FloatingActionButton(
                    child: Icon(Icons.mic),
                    backgroundColor: Colors.pink,
                    onPressed: () {
                      if (_isAvailable && !_isListening) {
                        _speechRecognition
                            .listen(locale: "en_US")
                            .then((value) => print('$value'));
                      }
                    }),
                FloatingActionButton(
                    child: Icon(Icons.stop),
                    mini: true,
                    backgroundColor: Colors.deepPurple,
                    onPressed: () {
                      if (_isListening) {
                        _speechRecognition.stop().then(
                            (value) => setState(() => _isListening = value));
                      }
                    })
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                  color: Colors.cyanAccent[100],
                  borderRadius: BorderRadius.circular(6.0)),
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Text(resultText),
            )
          ],
        ),
      ),
    );
  }
}
