import 'package:flutter/material.dart';
import 'SeeAllScreen.dart';
import 'Story.dart';
import 'Play_Song.dart'; // Ensure correct file name

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(
            color: Color(0xFF36B6FF),
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Colors.black,
        actions: const [
          CircleAvatar(backgroundColor: Colors.grey),
          SizedBox(width: 18),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCarousel(width),
            _buildSectionTitle("New Release", context),
            _buildHorizontalList([
              {
                "name": "Maa Dihaa",
                "artist": "DILU Beats",
                "image": "assets/maadiha.png",
                "url": "assets/audio/maa_dihaa.mp3"
              },
              {
                "name": "Mulawe",
                "artist": "Mihiran",
                "image": "assets/mulawe.jpeg",
                "url": "assets/audio/mulawe.mp3"
              },
              {
                "name": "Ayasaye",
                "artist": "Anushka",
                "image": "assets/ayasaye.jpeg",
                "url": "assets/audio/ayasaye.mp3"
              },
              {
                "name": "Ma Deparak",
                "artist": "Mihiran",
                "image": "assets/madeparak.png",
                "url": "assets/audio/Ma_Deparak.mp3"
              }
            ], context, "New Release"),
            const SizedBox(height: 20),
            _buildSectionTitle("Popular Artists", context),
            _buildHorizontalCircleList(
              ["Mihiran", "Yuki Navaratne", "DILU Beats", "Anushka Udana"],
              [
                "assets/mihiran.jpeg",
                "assets/yuki.jpeg",
                "assets/dilu.png",
                "assets/anushka.png"
              ],
            ),
            const SizedBox(height: 20),
            _buildSectionTitle("Album", context),
            _buildHorizontalList([
              {
                "name": "Mihiran & DILU",
                "artist": "Mihiran Procuction",
                "image": "assets/MIHIRAN_DILU.jpeg",
              },
              {
                "name": "English MIX",
                "artist": "ODD",
                "image": "assets/english_album.jpeg",
              },
              {
                "name": "Sinhala Rap",
                "artist": "Oneth D",
                "image": "assets/shan_putha.jpeg",               
              }
            ], context, "Album"),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF36B6FF),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SeeAllScreen(title: title)),
              );
            },
            child: const Text(
              "See All",
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalList(
      List<Map<String, String>> songs, BuildContext context, String sectionTitle) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: songs.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (sectionTitle == "Album") {
                // Navigate to SeeAllScreen to show album playlists
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SeeAllScreen(title: "Album"),
                  ),
                );
              } else {
                // Navigate to PlaySong
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlaySong(song: songs[index]),
                  ),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(songs[index]["image"]!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(songs[index]["name"]!,
                      style:
                          const TextStyle(color: Colors.white, fontSize: 14)),
                  Text(songs[index]["artist"]!,
                      style: TextStyle(color: Colors.grey[500], fontSize: 12)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHorizontalCircleList(List<String> names, List<String> imagePaths) {
    return SizedBox(
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: names.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Column(
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(imagePaths[index]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                Text(names[index],
                    style: const TextStyle(color: Colors.white, fontSize: 14)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCarousel(double width) {
    return SizedBox(
      height: 180,
      child: PageView(
        children: [
          _buildCarouselItem("assets/banner.png", width),
          _buildCarouselItem("assets/banner.png", width),
          _buildCarouselItem("assets/banner.png", width),
        ],
      ),
    );
  }

  Widget _buildCarouselItem(String imagePath, double width) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(imagePath,
            width: width * 0.9, height: 150, fit: BoxFit.cover),
      ),
    );
  }
}
