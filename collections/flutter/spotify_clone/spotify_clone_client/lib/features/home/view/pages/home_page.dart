import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone_client/core/theme/app_pallete.dart';
import 'package:spotify_clone_client/features/home/view/pages/library_page.dart';
import 'package:spotify_clone_client/features/home/view/pages/song_page.dart';
import 'package:spotify_clone_client/features/home/view/pages/upload_song_page.dart';
import 'package:spotify_clone_client/features/home/view/widgets/music_slab.dart';

class HomePage extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  int selectedIndex = 0;
  final pages = [SongPage(), LibraryPage(), UploadSongPage()];
  @override
  Widget build(BuildContext context) {
    print("Selected $selectedIndex");
    return Scaffold(
      body: Stack(
        children: [
          pages[selectedIndex],
          const Positioned(bottom: 0,child: MusicSlab())
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              selectedIndex == 0
                  ? 'assets/images/home_filled.png'
                  : 'assets/images/home_unfilled.png',
              color: selectedIndex == 0
                  ? AppPallete.whiteColor
                  : AppPallete.inactiveButtonBarItemColor,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/library.png',
              color: selectedIndex == 1
                  ? AppPallete.whiteColor
                  : AppPallete.inactiveButtonBarItemColor,
            ),
            label: "Library",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.upload),
            label: "Upload Song",
          ),
        ],
      ),
    );
  }
}
