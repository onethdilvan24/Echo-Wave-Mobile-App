import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlaySong extends StatefulWidget {
  final Map<String, String> song;

  const PlaySong({super.key, required this.song});

  @override
  _PlaySongState createState() => _PlaySongState();
}

class _PlaySongState extends State<PlaySong> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _loadSong();
    _audioPlayer.playingStream.listen((playing) {
      setState(() {
        _isPlaying = playing;
      });
    });
  }

  Future<void> _loadSong() async {
    try {
      await _audioPlayer.setAsset(widget.song["url"]!);
      _audioPlayer.durationStream.listen((d) {
        if (d != null) {
          setState(() => _duration = d);
        }
      });
      _audioPlayer.positionStream.listen((p) {
        setState(() => _position = p);
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error loading song: $e")),
      );
    }
  }

  void _playPause() async {
    if (_audioPlayer.playing) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play();
    }
  }

  void _seekTo(double seconds) {
    _audioPlayer.seek(Duration(seconds: seconds.toInt()));
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(duration.inMinutes)}:${twoDigits(duration.inSeconds.remainder(60))}";
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background Image with Blend Effect
          Positioned.fill(
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [Colors.black, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ).createShader(bounds);
              },
              blendMode: BlendMode.dstIn,
              child: Image.asset(
                widget.song["image"]!,
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Back Button
          Positioned(
            top: 40,
            left: 15,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),

          // UI Elements
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),

                  // Song Name
                  Text(
                    widget.song["name"]!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),

                  // Artist Name
                  Text(
                    widget.song["artist"]!,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),

                  // Progress Bar
                  Slider(
                    min: 0,
                    max: _duration.inSeconds.toDouble(),
                    value: _position.inSeconds.toDouble(),
                    onChanged: _seekTo,
                    activeColor: Colors.orange,
                    inactiveColor: Colors.white38,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_formatDuration(_position), style: const TextStyle(color: Colors.white)),
                      Text(_formatDuration(_duration), style: const TextStyle(color: Colors.white)),
                    ],
                  ),

                  // Play/Pause Button
                  IconButton(
                    icon: Icon(
                      _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                      size: 70,
                      color: Colors.white,
                    ),
                    onPressed: _playPause,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
