import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlaylistScreen extends StatefulWidget {
  final String playlistName;
  final String playlistImage;
  final List<Map<String, String>> songs;

  const PlaylistScreen({
    super.key,
    required this.playlistName,
    required this.songs,
    required this.playlistImage,
  });

  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  int? _currentIndex;

  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    super.initState();

    // Listen to song duration
    _audioPlayer.durationStream.listen((d) {
      if (d != null) {
        setState(() {
          _duration = d;
        });
      }
    });

    // Listen to song position updates
    _audioPlayer.positionStream.listen((p) {
      setState(() {
        _position = p;
      });
    });

    // Listen for song completion to automatically move to the next song
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _playNextSong();
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playPauseSong(int index) async {
    final songUrl = widget.songs[index]["url"];

    if (songUrl == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Song URL is missing')),
      );
      return;
    }

    if (_currentIndex == index && _isPlaying) {
      await _audioPlayer.pause();
      setState(() => _isPlaying = false);
    } else {
      try {
        if (songUrl.startsWith("assets/")) {
          await _audioPlayer.setAsset(songUrl);
        } else {
          await _audioPlayer.setUrl(songUrl);
        }

        await _audioPlayer.play();
        setState(() {
          _currentIndex = index;
          _isPlaying = true;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error playing song: $e')),
        );
      }
    }
  }

  void _seekTo(Duration position) {
    _audioPlayer.seek(position);
  }

  void _playNextSong() {
    if (_currentIndex != null && _currentIndex! < widget.songs.length - 1) {
      _playPauseSong(_currentIndex! + 1);
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
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

                // Playlist Cover Image
                Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(widget.playlistImage),
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
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "${widget.songs.length} songs",
                        style: const TextStyle(
                            color: Colors.white70, fontSize: 14),
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
        child: Column(
          children: [
            ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              leading: const Icon(Icons.music_note, color: Colors.white70),
              title: Text(
                song["name"] ?? 'Unknown Song',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                song["artist"] ?? 'Unknown Artist',
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              trailing: IconButton(
                icon: Icon(isPlayingSong ? Icons.pause : Icons.play_arrow,
                    color: Colors.white),
                onPressed: () => _playPauseSong(index),
              ),
            ),

            // Show progress bar only for the currently playing song
            if (isPlayingSong)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbShape:
                            const RoundSliderThumbShape(enabledThumbRadius: 8.0),
                        activeTrackColor: Colors.white,
                        inactiveTrackColor: Colors.white38,
                        thumbColor: Colors.white,
                        overlayColor: Colors.white24,
                      ),
                      child: Slider(
                        min: 0,
                        max: _duration.inSeconds.toDouble(),
                        value: _position.inSeconds.toDouble().clamp(
                            0.0, _duration.inSeconds.toDouble()),
                        onChanged: (value) {
                          _seekTo(Duration(seconds: value.toInt()));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _formatDuration(_position),
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 14),
                          ),
                          Text(
                            _formatDuration(_duration),
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

}
