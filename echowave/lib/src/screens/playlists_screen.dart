import 'package:flutter/material.dart';
import 'playlists.dart'; // Import PlaylistScreen

class PlaylistsScreen extends StatelessWidget {
  const PlaylistsScreen({super.key});

  // 🔹 List of Playlists
  static const List<Map<String, String>> playlists = [
    {
      "name": "CHILL",
      "image": "assets/madeparak.png",
    },
    {
      "name": "ENGLISH",
      "image": "assets/maadiha.png",
    },
  ];

  // 🔹 Songs for each Playlist
  static const Map<String, List<Map<String, String>>> playlistSongs = {
    "CHILL": [
      {"name": "Mulawe", "artist": "Mihiran", "url": "assets/audio/mulawe.mp3", "image": "assets/madeparak.png"},
      {"name": "Ma Deparak", "artist": "Mihiran", "url": "assets/audio/Ma_Deparak.mp3", "image": "assets/madeparak.png"},
      {"name": "Numba Ha", "artist": "DILU Beast", "url": "assets/audio/numba_ha.mp3", "image": "assets/madeparak.png"},
      {"name": "Alaapa Gee", "artist": "Yuki Navaratne", "url": "assets/audio/alaapa_gee.mp3", "image": "assets/madeparak.png"},
      {"name": "Manali", "artist": "Yuki Navaratne", "url": "assets/audio/manali.mp3", "image": "assets/madeparak.png"},
      {"name": "Dase Durin", "artist": "DILU Beast", "url": "assets/audio/dase_durin.mp3", "image": "assets/madeparak.png"},
      {"name": "Kiyaapan", "artist": "Anushka Udana", "url": "assets/audio/kiyaapan.mp3", "image": "assets/madeparak.png"},
      {"name": "Ayasaye", "artist": "Anushka Udana", "url": "assets/audio/ayasaye.mp3", "image": "assets/madeparak.png"},
    ],
    "ENGLISH": [
      {"name": "Darkside", "artist": "Alan Walker", "url": "https://example.com/song1.mp3", "image": "assets/maadiha.png"},
      {"name": "Yummy", "artist": "Justin Bieber", "url": "https://example.com/song2.mp3", "image": "assets/maadiha.png"},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Playlists",
          style: TextStyle(
            color: Color(0xFF36B6FF),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              // Handle add playlist action
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.white),
            onPressed: () {
              // Handle options action
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.separated(
          itemCount: playlists.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
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
        String playlistName = playlist["name"]!;
        List<Map<String, String>> songs = playlistSongs[playlistName] ?? []; // Get songs list
        String playlistImage = playlist["image"] ?? "assets/default_image.png"; // Ensure image is not null

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaylistScreen(
              playlistName: playlistName,
              songs: songs,
              playlistImage: playlistImage, // ✅ Pass the image correctly
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900], // Dark card background
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8), // To match the round edges
            child: Image.asset(
              playlist["image"]!, // Load the image from the asset
              width: 50,
              height: 50,
              fit: BoxFit.cover, // To ensure the image covers the box
            ),
          ),
          title: Text(
            playlist["name"] ?? 'Unknown Playlist', // Added a fallback in case name is missing
            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            "${playlistSongs[playlist["name"]]?.length ?? 0} songs", // Display song count
            style: const TextStyle(color: Colors.white70, fontSize: 14),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.more_horiz, color: Colors.white),
            onPressed: () {
              // Handle playlist item options
            },
          ),
        ),
      ),
    );
  }
}
