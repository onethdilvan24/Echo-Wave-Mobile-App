import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: const Color(0xFF36B6FF),
      unselectedItemColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home, size: 32), label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.search, size: 32), label: "Search"),
        BottomNavigationBarItem(icon: Icon(Icons.wifi_tethering, size: 32), label: "Trending"),
        BottomNavigationBarItem(icon: Icon(Icons.music_note, size: 32), label: "Music"),
      ],
    );
  }
}
