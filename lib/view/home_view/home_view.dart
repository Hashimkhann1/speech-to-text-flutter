import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speach_to_text/res/components/my_text.dart';

class HomeView extends StatefulWidget {
  HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final SpeechToText _speechToText = SpeechToText();

  bool speechEnabled = false;
  String wordsSpoken = '';
  double confidenceLevel = 0;

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  void initSpeech() async {
    speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {
      confidenceLevel = 0;
    });
  }

  void _onSpeechResult(result) {
    setState(() {
      wordsSpoken = result.recognizedWords;
      confidenceLevel = result.confidence;
    });
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(
          title: "Speech to text",
        ),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: MyText(
              title: _speechToText.isListening
                  ? "Listing..."
                  : speechEnabled
                  ? "Tap the microphone to start listening..."
                  : "Speech not available",
              fontSize: 20,
              color: Colors.green,
            ),
          ),
          
          Container(
            child: MyText(title: wordsSpoken,fontSize: 22,fontWeight: FontWeight.bold,),
          ),

          if(_speechToText.isNotListening && confidenceLevel > 0)
            MyText(title: "Confidence Level: ${(confidenceLevel * 100).toStringAsFixed(1)}%",fontSize: 20,)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: _speechToText.isListening ? _stopListening : _startListening,
        tooltip: "Listing",
        child: Icon(
          _speechToText.isListening ? Icons.mic : Icons.mic_off,
          color: Colors.white,
        ),
      ),
    );
  }
}
