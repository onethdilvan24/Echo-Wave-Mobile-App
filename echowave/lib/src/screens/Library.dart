import 'package:flutter/material.dart';
import 'playlists_screen.dart';
import 'artists_screen.dart';
import 'songs_screen.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Library",
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            _buildLibraryItem(Icons.library_music, "Playlists", context, const PlaylistsScreen()),
            _buildLibraryItem(Icons.mic, "Artists", context, const ArtistsScreen()),           
            _buildLibraryItem(Icons.music_note, "Songs", context, const SongsScreen()),
          ],
        ),
      ),
    );
  }

  Widget _buildLibraryItem(IconData icon, String title, BuildContext context, Widget screen) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Color(0xFF36B6FF)),
          title: Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => screen),
            );
          },
        ),
        const Divider(color: Colors.white54, thickness: 0.2),
      ],
    );
  }
}
