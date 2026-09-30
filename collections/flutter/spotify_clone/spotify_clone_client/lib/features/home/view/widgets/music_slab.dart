import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone_client/core/providers/current_song_notifier.dart';
import 'package:spotify_clone_client/core/theme/app_pallete.dart';
import 'package:spotify_clone_client/features/home/view/widgets/music_player.dart';

class MusicSlab extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSong = ref.watch(currentSongProvider);
    final songNotifier = ref.read(currentSongProvider.notifier);
    // print("Current Song: $currentSong");
    if (currentSong == null) {
      return const SizedBox();
    }
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return const MusicPlayer();
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  final tween = Tween(
                    begin: Offset(0, 1),
                    end: Offset.zero,
                  ).chain(CurveTween(curve: Curves.easeIn));
                  final offsetAnimation = animation.drive(tween);
                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
          ),
        );
      },
      child: Stack(
        children: [
          AnimatedContainer(
            duration: Duration(seconds: 2),
            height: 66,
            width: MediaQuery.of(context).size.width - 16,
            decoration: BoxDecoration(
              color: Color(
                int.parse("FF${currentSong.value!.color}", radix: 16),
              ),
              borderRadius: BorderRadius.horizontal(right: Radius.circular(15)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Hero(
                        tag: "music-image",
                        child: SizedBox(
                          width: 48,
                          child: ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(10),
                            child: Image.network(
                              currentSong.value!.thumbnailURL,
                              // fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Column(
                        children: [
                          Text(
                            currentSong.value!.songName,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(currentSong.value!.artistName),
                        ],
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    IconButton(onPressed: () {}, icon: Icon(Icons.favorite)),
                    IconButton(
                      onPressed: () {
                        songNotifier.togglePlay();
                      },
                      icon: Icon(
                        songNotifier.isPlaying ? Icons.pause : Icons.play_arrow,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          StreamBuilder(
            stream: songNotifier.audioPlayer?.positionStream,
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.connectionState == ConnectionState.waiting) {
                return SizedBox();
              }
              final songDuration = songNotifier.audioPlayer?.duration;
              final position = asyncSnapshot.data;
              double sliderValue = 0.0;
              if (songDuration != null && position != null) {
                sliderValue =
                    position.inMilliseconds / songDuration.inMilliseconds;
              }
              return Positioned(
                left: 8,
                bottom: 0,
                child: Container(
                  height: 2,
                  width: sliderValue * (MediaQuery.of(context).size.width - 32),
                  decoration: BoxDecoration(
                    color: AppPallete.whiteColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              );
            },
          ),
          Positioned(
            left: 8,
            bottom: 0,
            child: Container(
              height: 2,
              width: MediaQuery.of(context).size.width - 35,
              decoration: BoxDecoration(
                color: AppPallete.inactiveSeekColor,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
