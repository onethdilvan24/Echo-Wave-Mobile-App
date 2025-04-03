import 'package:flutter/material.dart';
import 'Play_Song.dart';

class SongsScreen extends StatelessWidget {
  const SongsScreen({super.key});

  static const List<Map<String, String>> playlists = [
    {
      "name": "Ma Deparak",
      "artist": "Mihiran",
      "image": "assets/madeparak.png",
      "url": "assets/audio/Ma_Deparak.mp3"
    },
    {
      "name": "Maa Diha",
      "artist": "DILU Beats",
      "image": "assets/maadiha.png",
      "url": "assets/audio/maa_dihaa.mp3"
    },
    {
      "name": "Ayasaye",
      "artist": "Anushka Udana",
      "image": "assets/ayasaye_1.png",
      "url": "assets/audio/ayasaye.mp3"
    },
    {
      "name": "Mulawe",
      "artist": "Mihiran",
      "image": "assets/mulawe.jpeg",
      "url": "assets/audio/mulawe.mp3"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: const Text(
          "Favourite Songs",
          style: TextStyle(
            color: Color(0xFF36B6FF),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: playlists.length,
          itemBuilder: (context, index) {
            return _buildPlaylistItem(context, playlists[index]);
          },
        ),
      ),
    );
  }

  Widget _buildPlaylistItem(BuildContext context, Map<String, String> playlist) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaySong(song: playlist),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              playlist["image"]!,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(
            playlist["name"]!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "Artist: ${playlist["artist"]!}",
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
