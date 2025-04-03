import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';

class RadioScreen extends StatefulWidget {
  const RadioScreen({super.key});

  @override
  _RadioScreenState createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> with SingleTickerProviderStateMixin {
  bool isListening = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  String recognizedSong = "";
  final AudioRecorder _recorder = AudioRecorder();
  String? _audioPath;

  @override
  void initState() {
    super.initState();
    requestIOSPermission(); // Request permission for iOS

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  Future<void> requestIOSPermission() async {
    await _recorder.hasPermission();
  }

  Future<void> startRecording() async {
    if (await _recorder.hasPermission()) {
      final dir = await getTemporaryDirectory();
      _audioPath = '${dir.path}/audio.wav';
      await _recorder.start(const RecordConfig(encoder: AudioEncoder.wav), path: _audioPath!);
    }
  }

  Future<void> stopRecording() async {
    await _recorder.stop();
    if (_audioPath != null) {
      recognizeSong(_audioPath!);
    }
  }

  Future<void> recognizeSong(String filePath) async {
    const String apiKey = "38b4727a8c251deed8aff454e119d569";
    const String apiUrl = "https://api.audd.io/";

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.fields['api_token'] = apiKey;
    request.fields['return'] = 'timecode';
    request.files.add(await http.MultipartFile.fromPath('file', filePath));

    var response = await request.send();
    var responseData = await response.stream.bytesToString();
    var jsonData = json.decode(responseData);

    if (jsonData["status"] == "success" && jsonData["result"] != null) {
      setState(() {
        recognizedSong = "${jsonData["result"]["title"]} - ${jsonData["result"]["artist"]}";
      });
    } else {
      setState(() {
        recognizedSong = "No song recognized";
      });
    }
  }

  void _onTap() async {
    setState(() {
      isListening = !isListening;
    });

    if (isListening) {
      _controller.repeat(reverse: true);
      await startRecording();
    } else {
      _controller.reset();
      await stopRecording();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _recorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Listening",
          style: TextStyle(
            color: Color(0xFF36B6FF),
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: const [
          CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 20,
          ),
          SizedBox(width: 18),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/video_placeholder.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          GestureDetector(
            onTap: _onTap,
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF36B6FF),
                ),
                child: Center(
                  child: Icon(
                    isListening ? Icons.hearing : Icons.music_note,
                    color: Colors.white,
                    size: 50,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 120,
            child: Column(
              children: [
                AnimatedOpacity(
                  opacity: isListening ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: const Text(
                    "Listening for music",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                const SizedBox(height: 5),
                AnimatedOpacity(
                  opacity: isListening ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 500),
                  child: const Text(
                    "Make sure your device can hear the song clearly",
                    style: TextStyle(color: Colors.white60, fontSize: 14),
                  ),
                ),
                if (recognizedSong.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      recognizedSong,
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: RadioScreen(),
  ));
}
