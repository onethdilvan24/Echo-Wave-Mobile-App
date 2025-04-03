import 'package:flutter/material.dart';
import 'ArtistsScreen.dart'; // Assuming the file for the next screen is PlaylistDetailScreen.dart.

class ArtistsScreen extends StatelessWidget {
  const ArtistsScreen({super.key});

  // Updated artist data with songs specific to each artist.
  final List<Map<String, dynamic>> artists = const [
    {
      "name": "Mihiran",
      "image": "assets/mihiran.jpeg",
      "songs": [
        {"name": "Mulawe", "artist": "Mihiran", "url": "assets/audio/mulawe.mp3"},
        {"name": "Ma Deparak", "artist": "Mihiran", "url": "assets/audio/Ma_Deparak.mp3"},
        {"name": "Maga Haree", "artist": "Mihiran", "url": "assets/audio/maga_haree.mp3"},
        {"name": "Riduman", "artist": "Mihiran", "url": "assets/audio/riduman.mp3"},
        {"name": "Charikawak", "artist": "Mihiran", "url": "assets/audio/charikawak.mp3"},
        {"name": "Sanda Nena da", "artist": "Mihiran", "url": "assets/audio/sanda_nena_da.mp3"},
      ]
    },
    {
      "name": "Yuki Navaratne",
      "image": "assets/yuki.jpeg",
      "songs": [
        {"name": "Nohithunata", "artist": "Yuki Navaratne", "url": "assets/audio/nohithunata.mp3"},
        {"name": "Me Hitha Na Palu", "artist": "Yuki Navaratne", "url": "assets/audio/me_hitha_na_palu.mp3"},
        {"name": "Rasthafari", "artist": "Yuki Navaratne", "url": "assets/audio/rasthafari.mp3"},
        {"name": "Boho De", "artist": "Yuki Navaratne", "url": "assets/audio/boho_de.mp3"},
        {"name": "Wisithuru Mal", "artist": "Yuki Navaratne", "url": "assets/audio/wisithuru_mal.mp3"},
        {"name": "Alaapa Gee", "artist": "Yuki Navaratne", "url": "assets/audio/alaapa_gee.mp3"},
        {"name": "Manali", "artist": "Yuki Navaratne", "url": "assets/audio/manali.mp3"},
      ]
    },
    {
      "name": "DILU Beast",
      "image": "assets/dilu.png",
      "songs": [
        {"name": "Neth Manema", "artist": "DILU Beast", "url": "assets/audio/neth_manema.mp3"},
        {"name": "Numba Ha", "artist": "DILU Beast", "url": "assets/audio/numba_ha.mp3"},
        {"name": "Mawila", "artist": "DILU Beast", "url": "assets/audio/mawila.mp3"},
        {"name": "Dase Durin", "artist": "DILU Beast", "url": "assets/audio/dase_durin.mp3"},
        {"name": "Sithuwam Hade", "artist": "DILU Beast", "url": "assets/audio/sithuwam_hade.mp3"},
        {"name": "Maa Dihaa", "artist": "DILU Beast", "url": "assets/audio/maa_dihaa.mp3"},
        {"name": "Handa Gawin", "artist": "DILU Beast", "url": "assets/audio/handa_gawin.mp3"},
      ]
    },
    {
      "name": "Anushka Udana",
      "image": "assets/anushka.png",
      "songs": [
        {"name": "Mandaram Kathawe", "artist": "Anushka Udana", "url": "assets/audio/mandaram_kathawe.mp3"},
        {"name": "Marunu Hithe", "artist": "Anushka Udana", "url": "assets/audio/marunu_hithe.mp3"},
        {"name": "Kiyaapan", "artist": "Anushka Udana", "url": "assets/audio/kiyaapan.mp3"},
        {"name": "Ayasaye", "artist": "Anushka Udana", "url": "assets/audio/ayasaye.mp3"},
      ]
    },
  ];

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
          "Artists",
          style: TextStyle(
            color: Color(0xFF36B6FF),
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 artists per row
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemCount: artists.length,
          itemBuilder: (context, index) {
            return _buildArtistItem(context, artists[index]);
          },
        ),
      ),
    );
  }

  Widget _buildArtistItem(BuildContext context, Map<String, dynamic> artist) {
    return GestureDetector(
      onTap: () {
        // Navigate to PlaylistDetailScreen when an artist is tapped
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaylistDetailScreen(
              playlistName: artist["name"]!,
              playlistImage: artist["image"]!,
              songs: artist["songs"]!, // Pass the artist-specific songs here
            ),
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 70,
            backgroundColor: Colors.grey, // Placeholder for artist image
            child: artist["image"]!.isNotEmpty
                ? ClipOval(
                    child: Image.asset(
                      artist["image"]!,
                      fit: BoxFit.cover,
                      width: 150,
                      height: 150,
                    ),
                  )
                : null,
          ),
          const SizedBox(height: 8),
          Text(
            artist["name"]!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
