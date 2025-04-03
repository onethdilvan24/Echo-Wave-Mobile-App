import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlaylistDetailScreen extends StatefulWidget {
  final String playlistName;
  final List<Map<String, String>> songs;
  final String genreImage;  // Add genreImage parameter

  const PlaylistDetailScreen({
    super.key,
    required this.playlistName,
    required this.songs,
    required this.genreImage,  // Initialize genreImage
  });

  @override
  _PlaylistDetailScreenState createState() => _PlaylistDetailScreenState();
}

class _PlaylistDetailScreenState extends State<PlaylistDetailScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  int? _currentIndex;

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playPauseSong(int index) async {
    final songUrl = widget.songs[index]["url"];

    if (songUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Song URL is missing')));
      return;
    }

    if (_currentIndex == index && _isPlaying) {
      await _audioPlayer.pause();
      setState(() => _isPlaying = false);
    } else {
      try {
        await _audioPlayer.setUrl(songUrl);
        await _audioPlayer.play();
        setState(() {
          _currentIndex = index;
          _isPlaying = true;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error playing song: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color.fromARGB(255, 43, 182, 233), Colors.black],
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_horiz, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),

                // Display Genre Image
                Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(widget.genreImage), // Use the passed genre image
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Playlist Name & Song Count
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.playlistName,
                        style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${widget.songs.length} songs",
                        style: const TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Song List
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.songs.length,
                    itemBuilder: (context, index) {
                      var song = widget.songs[index];
                      return _buildSongItem(index, song);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSongItem(int index, Map<String, String> song) {
    bool isPlayingSong = _isPlaying && _currentIndex == index;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(116, 91, 196, 249),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: const Icon(Icons.music_note, color: Colors.white70),
          title: Text(
            song["name"] ?? 'Unknown Song',
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            song["artist"] ?? 'Unknown Artist',
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          trailing: IconButton(
            icon: Icon(isPlayingSong ? Icons.pause : Icons.play_arrow, color: Colors.white),
            onPressed: () => _playPauseSong(index),
          ),
        ),
      ),
    );
  }
}
