import 'package:flutter/material.dart';
import 'playlists.dart'; // Ensure this file exists and is correctly imported

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    // List of genres
    final List<String> genres = [
      "Pop", "Rock", "Hip-Hop", "Jazz", "Classical", "Electronic", "Workout", "Tv & Film"
    ];

    // Corresponding image paths for each genre
    final List<String> genreImages = [
      "assets/pop.jpeg", "assets/rock.jpg", "assets/hiphop.jpg",
      "assets/jazz.jpeg", "assets/classical.png", "assets/electronic.jpg",
      "assets/workout.webp", "assets/movie.jpg"
    ];

    // Sample songs for each genre
    final List<List<Map<String, String>>> genreSongs = [
      // "Pop"
      [
        {"name": "Get Lucky", "artist": "Daft Punk", "url": "assets/audio/Get_Lucky_Daft_punk.mp3", "image": "assets/pop.jpg"},
        {"name": "Hotline Bling", "artist": "Drake", "url": "assets/audio/Hotline_Bling_Drake.mp3", "image": "assets/pop_song2.jpg"},
        {"name": "Toxic", "artist": "Britney Spears", "url": "assets/audio/Toxic_Britney_Spears.mp3", "image": "assets/pop_song2.jpg"},
      ],
      // "Rock"
      [
        {"name": "Bring Me To Life", "artist": "Evanescence", "url": "assets/audio/Bring_Me_To_Life.mp3", "image": "assets/rock_song1.jpg"},
        {"name": "In The End", "artist": "Linkin Park", "url": "assets/audio/In_the_end.mp3", "image": "assets/rock_song2.jpg"},
        {"name": "The Final Countdown", "artist": "Europe", "url": "assets/audio/The_Final_Countdown.mp3", "image": "assets/rock_song2.jpg"},
      ],
      // "Hip-Hop"
      [
        {"name": "All My Life", "artist": "Lil Durk", "url": "assets/audio/All_My_Life.mp3", "image": "assets/hiphop_song1.jpg"},
        {"name": "Bodak Yellow", "artist": "Cardi B", "url": "assets/audio/Bodak_Yellow.mp3", "image": "assets/hiphop_song2.jpg"},
        {"name": "Sicko Mode", "artist": "Travis Scott", "url": "assets/audio/SICKO_MODE.mp3", "image": "assets/hiphop_song3.jpg"},
      ],
      // "Jazz"
      [
        {"name": "Naima", "artist": "John Coltrane", "url": "assets/audio/Naima.mp3", "image": "assets/jazz_song1.jpg"},
        {"name": "So What", "artist": "Miles Davis", "url": "assets/audio/So_What.mp3", "image": "assets/jazz_song2.jpg"},
        {"name": "Take Five", "artist": "Dave Brubeck", "url": "assets/audio/Take_Five.mp3", "image": "assets/jazz_song3.jpg"},
      ],
      // "Classical"
[
  {
    "name": "Für Elise",
    "artist": "Ludwig van Beethoven",
    "url": "assets/audio/Fur_Elise_Beethoven.mp3",
    "image": "assets/classical_song1.jpg"
  },
  {
    "name": "Rondo Alla Turca",
    "artist": "Minh Râu, TimmyDzi",
    "url": "assets/audio/Rondo_Alla_Turca_Mozart.mp3",
    "image": "assets/classical_song2.jpg"
  },
  {
    "name": "Spring",
    "artist": "Antonio Vivaldi",
    "url": "assets/audio/Spring_Vivaldi.mp3",
    "image": "assets/classical_song3.jpg"
  }
],

// "Electronic"
[
  {
    "name": "Animals",
    "artist": "Martin Garrix",
    "url": "assets/audio/Animals_Martin_Garrix.mp3",
    "image": "assets/electronic_song1.jpg"
  },
  {
    "name": "Titanium",
    "artist": "David Guetta",
    "url": "assets/audio/Titanium_David_Guetta.mp3",
    "image": "assets/electronic_song2.jpg"
  },
  {
    "name": "Wake Me Up",
    "artist": "Avicii",
    "url": "assets/audio/Wake_Me_Up_Avicii.mp3",
    "image": "assets/electronic_song3.jpg"
  }
],

// "Workout"
[
  {
    "name": "Remember the Name",
    "artist": "Fort Minor",
    "url": "assets/audio/Remember_The_Name_Fort_Minor.mp3",
    "image": "assets/workout_song1.jpg"
  },
  {
    "name": "Stronger",
    "artist": "Kanye West",
    "url": "assets/audio/Stronger_Kanye_West.mp3",
    "image": "assets/workout_song2.jpg"
  },
  {
    "name": "Till I Collapse",
    "artist": "Eminem",
    "url": "assets/audio/Till_I_Collapse_Eminem.mp3",
    "image": "assets/workout_song3.jpg"
  }
],

// "Tv & Film"
[
  {
    "name": "Battle Cry",
    "artist": "Imagine Dragons",
    "url": "assets/audio/Battle_Cry_Imagine_Dragons.mp3",
    "image": "assets/tv_film_song1.jpg"
  },
  {
    "name": "Gonna Fly Now",
    "artist": "Bill Conti",
    "url": "assets/audio/Gonna_Fly_Now_Bill_Conti.mp3",
    "image": "assets/tv_film_song2.jpg"
  },
  {
    "name": "Time",
    "artist": "Hans Zimmer",
    "url": "assets/audio/Time_Hans_Zimmer.mp3",
    "image": "assets/tv_film_song3.jpg"
  }
]

    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Search",
          style: TextStyle(color: Color(0xFF36B6FF), fontSize: 30, fontWeight: FontWeight.w700),
        ),
        backgroundColor: Colors.black,
        actions: const [CircleAvatar(backgroundColor: Colors.grey), SizedBox(width: 18)],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[800], borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.white54),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Artists, Songs, Lyrics and More",
                        hintStyle: TextStyle(color: Colors.white54),
                        border: InputBorder.none,
                      ),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  IconButton(icon: const Icon(Icons.mic, color: Colors.blueAccent), onPressed: () {}),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Genre Grid
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10, childAspectRatio: 2,
                ),
                itemCount: genres.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      // Navigate to PlaylistScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlaylistScreen(
                            playlistName: genres[index], // Genre name
                            songs: genreSongs[index], // Songs list
                            playlistImage: genreImages[index], // Genre image
                          ),
                        ),
                      );
                    },
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: AssetImage(genreImages[index]),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.5), BlendMode.darken,
                          ),
                        ),
                      ),
                      child: Text(
                        genres[index],
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
