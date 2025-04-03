import 'package:flutter/material.dart';
import 'playlists.dart';
import 'Play_Song.dart';

class SeeAllScreen extends StatelessWidget {
  final String title;

  const SeeAllScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title,
            style: const TextStyle(
                color: Color(0xFF36B6FF),
                fontSize: 24,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: _getBodyContent(context, title),
    );
  }

  Widget _getBodyContent(BuildContext context, String title) {
    title = title.trim().toLowerCase();
    print("Received title in SeeAllScreen: '$title'");

    switch (title) {
      case "new release":
        return _buildNewReleases(context);
      case "popular artists":
        return _buildTopCharts(context);
      case "album":
        return _buildPlaylists(context);
      default:
        return Center(
          child: Text("All $title content goes here",
              style: const TextStyle(color: Colors.white, fontSize: 18)),
        );
    }
  }

  Widget _buildNewReleases(BuildContext context) {
    List<Map<String, String>> songs = [
      {
        "title": "Ma Deparak",
        "artist": "Mihiran",
        "image": "assets/madeparak.png",
        "url": "https://example.com/ma_deparak.mp3"
      },
      {
        "title": "Maa diha",
        "artist": "DILU Beats",
        "image": "assets/maa_dihaa.jpg",
        "url": "https://example.com/maa_diha.mp3"
      },
      {
        "title": "Ayasaye",
        "artist": "Anushka Udana",
        "image": "assets/ayasaye.jpeg",
        "url": "https://example.com/ayasaye.mp3"
      },
      {
        "title": "Mulawe",
        "artist": "Mihiran",
        "image": "assets/mulawe.jpeg",
        "url": "https://example.com/mulawe.mp3"
      },
    ];

    return ListView.builder(
      itemCount: songs.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(8),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                songs[index]["image"]!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              songs[index]["title"]!,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Artist: ${songs[index]["artist"]}",
              style: TextStyle(color: Colors.grey[400]),
            ),
            trailing: const Icon(Icons.more_vert, color: Colors.white),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlaySong(
                    song: {
                      "name": songs[index]["title"]!,
                      "artist": songs[index]["artist"]!,
                      "image": songs[index]["image"]!,
                      "url": songs[index]["url"]!,
                    },
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildTopCharts(BuildContext context) {
    final List<Map<String, dynamic>> topCharts = [
      {
        "name": "Mihiran",
        "image": "assets/mihiran.jpeg",
        "songs": [
          {
            "name": "Mulawe",
            "artist": "Mihiran",
            "url": "assets/audio/mulawe.mp3"
          },
          {
            "name": "Ma Deparak",
            "artist": "Mihiran",
            "url": "assets/audio/Ma_Deparak.mp3"
          },
          {
            "name": "Maga Haree",
            "artist": "Mihiran",
            "url": "assets/audio/maga_haree.mp3"
          },
          {
            "name": "Riduman",
            "artist": "Mihiran",
            "url": "assets/audio/riduman.mp3"
          },
          {
            "name": "Charikawak",
            "artist": "Mihiran",
            "url": "assets/audio/charikawak.mp3"
          },
          {
            "name": "Sanda Nena da",
            "artist": "Mihiran",
            "url": "assets/audio/sanda_nena_da.mp3"
          },
        ]
      },
      {
        "name": "Yuki Navaratne",
        "image": "assets/yuki.jpeg",
        "songs": [
          {
            "name": "Nohithunata",
            "artist": "Yuki Navaratne",
            "url": "assets/audio/nohithunata.mp3"
          },
          {
            "name": "Me Hitha Na Palu",
            "artist": "Yuki Navaratne",
            "url": "assets/audio/me_hitha_na_palu.mp3"
          },
          {
            "name": "Rasthafari",
            "artist": "Yuki Navaratne",
            "url": "assets/audio/rasthafari.mp3"
          },
          {
            "name": "Boho De",
            "artist": "Yuki Navaratne",
            "url": "assets/audio/boho_de.mp3"
          },
          {
            "name": "Wisithuru Mal",
            "artist": "Yuki Navaratne",
            "url": "assets/audio/wisithuru_mal.mp3"
          },
          {
            "name": "Alaapa Gee",
            "artist": "Yuki Navaratne",
            "url": "assets/audio/alaapa_gee.mp3"
          },
          {
            "name": "Manali",
            "artist": "Yuki Navaratne",
            "url": "assets/audio/manali.mp3"
          },
        ]
      },
      {
        "name": "DILU Beast",
        "image": "assets/dilu.png",
        "songs": [
          {
            "name": "Neth Manema",
            "artist": "DILU Beast",
            "url": "assets/audio/neth_manema.mp3"
          },
          {
            "name": "Numba Ha",
            "artist": "DILU Beast",
            "url": "assets/audio/numba_ha.mp3"
          },
          {
            "name": "Mawila",
            "artist": "DILU Beast",
            "url": "assets/audio/mawila.mp3"
          },
          {
            "name": "Dase Durin",
            "artist": "DILU Beast",
            "url": "assets/audio/dase_durin.mp3"
          },
          {
            "name": "Sithuwam Hade",
            "artist": "DILU Beast",
            "url": "assets/audio/sithuwam_hade.mp3"
          },
          {
            "name": "Maa Dihaa",
            "artist": "DILU Beast",
            "url": "assets/audio/maa_dihaa.mp3"
          },
          {
            "name": "Handa Gawin",
            "artist": "DILU Beast",
            "url": "assets/audio/handa_gawin.mp3"
          },
        ]
      },
      {
        "name": "Anushka Udana",
        "image": "assets/anushka.png",
        "songs": [
          {
            "name": "Mandaram Kathawe",
            "artist": "Anushka Udana",
            "url": "assets/audio/mandaram_kathawe.mp3"
          },
          {
            "name": "Marunu Hithe",
            "artist": "Anushka Udana",
            "url": "assets/audio/marunu_hithe.mp3"
          },
          {
            "name": "Kiyaapan",
            "artist": "Anushka Udana",
            "url": "assets/audio/kiyaapan.mp3"
          },
          {
            "name": "Ayasaye",
            "artist": "Anushka Udana",
            "url": "assets/audio/ayasaye.mp3"
          },
        ]
      },
    ];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        itemCount: topCharts.length,
        itemBuilder: (context, index) {
          return _buildChartItem(context, topCharts[index]);
        },
      ),
    );
  }

  Widget _buildChartItem(BuildContext context, Map<String, dynamic> chartItem) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlaylistScreen(
              playlistName: chartItem["name"]!,
              songs: List<Map<String, String>>.from(chartItem["songs"]),
              playlistImage: chartItem["image"]!,
            ),
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 70,
            backgroundColor: Colors.grey,
            child: ClipOval(
              child: Image.asset(
                chartItem["image"]!,
                fit: BoxFit.cover,
                width: 150,
                height: 150,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            chartItem["name"]!,
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

  Widget _buildPlaylists(BuildContext context) {
    List<Map<String, dynamic>> playlists = [
      {
        "name": "Mihiran & DILU",
        "songs": [
          {
            "name": "Mulawe",
            "artist": "Mihiran",
            "url": "assets/audio/mulawe.mp3"
          },
          {
            "name": "Dase Durin",
            "artist": "DILU Beast",
            "url": "assets/audio/dase_durin.mp3"
          },
          {
            "name": "Ma Deparak",
            "artist": "Mihiran",
            "url": "assets/audio/Ma_Deparak.mp3"
          },
          {
            "name": "Numba Ha",
            "artist": "DILU Beast",
            "url": "assets/audio/numba_ha.mp3"
          },
          {
            "name": "Maga Haree",
            "artist": "Mihiran",
            "url": "assets/audio/maga_haree.mp3"
          },
          {
            "name": "Neth Manema",
            "artist": "DILU Beast",
            "url": "assets/audio/neth_manema.mp3"
          },
          {
            "name": "Mawila",
            "artist": "DILU Beast",
            "url": "assets/audio/mawila.mp3"
          },
        ],
        "image": "assets/MIHIRAN_DILU.jpeg",
      },
      {
        "name": "English MIX",
        "songs": [
          {
            "name": "Get Lucky",
            "artist": "Daft Punk",
            "url": "assets/audio/Pop/Get_Lucky_Daft_punk.mp3"
          },
          {
            "name": "Hotline Bling",
            "artist": "Drake",
            "url": "assets/audio/Pop/Hotline_ Bling_Drake.mp3"
          },
          {
            "name": "Battle Cry",
            "artist": "Imagine Dragons",
            "url": "assets/audio/Tv and films/Battle_Cry_Imagine_dragons.mp3"
          },
          {
            "name": "Stronger",
            "artist": "Kanye West",
            "url": "assets/audio/workout/Stronger_Kanye West.mp3"
          },
          {
            "name": "Titanium",
            "artist": "David Guetta",
            "url": "assets/audio/Electronic/Titanium_David Guetta.mp3"
          },
          {
            "name": "Time",
            "artist": "Hans Zimmer",
            "url": "assets/audio/Tv and films/Time_Hans_Zimmer.mp3"
          },
        ],
        "image": "assets/english_album.jpeg",
      },
      {
        "name": "Sinhala Rap",
        "songs": [
          {
            "name": "Song A",
            "artist": "John Doe",
            "url": "https://example.com/songA.mp3"
          },
          {
            "name": "Song B",
            "artist": "Jane Doe",
            "url": "https://example.com/songB.mp3"
          },
        ],
        "image": "assets/shan_putha.jpeg",
      },
    ];

    return ListView.builder(
      itemCount: playlists.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(12),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(8),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                playlists[index]["image"]!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(
              playlists[index]["name"]!,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "${playlists[index]["songs"].length} songs",
              style: TextStyle(color: Colors.grey[400]),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlaylistScreen(
                    playlistName: playlists[index]["name"]!,
                    songs: List<Map<String, String>>.from(
                        playlists[index]["songs"]),
                    playlistImage: playlists[index]["image"]!,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
