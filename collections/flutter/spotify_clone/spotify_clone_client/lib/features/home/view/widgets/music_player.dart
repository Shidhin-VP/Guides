import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone_client/core/providers/current_song_notifier.dart';
import 'package:spotify_clone_client/core/theme/app_pallete.dart';

class MusicPlayer extends ConsumerWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songProvider = ref.watch(currentSongProvider);
    final songNotifier = ref.read(currentSongProvider.notifier);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(int.parse(songProvider!.value!.color, radix: 16)),
            const Color(0xff121212),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: AppPallete.transparentColor,
        appBar: AppBar(
          backgroundColor: AppPallete.transparentColor,
          leading: Transform.translate(
            offset: const Offset(-15, 0),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Image.asset('assets/images/pull-down-arrow.png'),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Hero(
                  tag: "music-image",
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(30),
                      child: Image.network(
                        songProvider.value!.thumbnailURL,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.broken_image_sharp);
                        },
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              songProvider.value!.songName,
                              style: TextStyle(
                                color: AppPallete.whiteColor,
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              songProvider.value!.artistName,
                              style: TextStyle(
                                color: AppPallete.subtitleText,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.heart,
                            color: AppPallete.whiteColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    StreamBuilder(
                      stream: songNotifier.audioPlayer!.positionStream,
                      builder: (context, asyncSnapshot) {
                        if (asyncSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return SizedBox();
                        }
                        final songDuration = songNotifier.audioPlayer!.duration;
                        final songPosition = asyncSnapshot.data;
                        double sliderValue = 0.0;
                        if (songDuration != null && songPosition != null) {
                          sliderValue =
                              songPosition.inMilliseconds /
                              songDuration.inMilliseconds;
                        }
                        return Column(
                          children: [
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: AppPallete.whiteColor,
                                inactiveTrackColor:
                                    AppPallete.inactiveSeekColor,
                                thumbColor: AppPallete.whiteColor,
                                trackHeight: 4,
                                overlayShape: SliderComponentShape.noOverlay,
                              ),
                              child: Slider(
                                value: sliderValue,
                                min: 0,
                                max: 1,
                                onChanged: (val) {
                                  sliderValue = val;
                                },
                                onChangeEnd: (value) {
                                  songNotifier.seekSong(value);
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  ("${songPosition!.inMinutes}:${(songPosition.inSeconds >= 10) ? songPosition.inSeconds : "0${songPosition.inSeconds}"}"),
                                ),
                                Text(
                                  "${songDuration!.inMinutes}:${songDuration.inSeconds}",
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.shuffle,
                            color: AppPallete.whiteColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.backward_end_fill,
                            color: AppPallete.whiteColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            songNotifier.togglePlay();
                          },
                          icon: Icon(
                            songNotifier.isPlaying
                                ? CupertinoIcons.pause_circle_fill
                                : CupertinoIcons.play_circle_fill,
                            size: 80,
                            color: AppPallete.whiteColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.forward_end_fill,
                            color: AppPallete.whiteColor,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(CupertinoIcons.repeat),
                          color: AppPallete.whiteColor,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            'assets/images/connect-device.png',
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/images/playlist.png'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
