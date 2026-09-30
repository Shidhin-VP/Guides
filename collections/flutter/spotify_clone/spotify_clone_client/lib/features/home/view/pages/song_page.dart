import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:spotify_clone_client/core/providers/current_song_notifier.dart';
import 'package:spotify_clone_client/core/theme/app_pallete.dart';
import 'package:spotify_clone_client/core/utils/general_app_status.dart';
import 'package:spotify_clone_client/core/widgets/loader.dart';
import 'package:spotify_clone_client/features/home/viewmodel/home_viewmodel.dart';

class SongPage extends ConsumerStatefulWidget {
  const SongPage({super.key});

  @override
  ConsumerState<SongPage> createState() => _SongPageState();
}

class _SongPageState extends ConsumerState<SongPage> {
  @override
  Widget build(BuildContext context) {
    final recentlyPlayedSongs = ref
        .watch(homeViewModelProvider.notifier)
        .getRecentlyPlayed();
    final songProvider = ref.watch(currentSongProvider);
    final songNotifier = ref.read(currentSongProvider.notifier);
    ref.listen(currentSongProvider, (_, next) {
      next?.when(
        data: (data) {},
        error: (error, st) {
          showAppStatus(context, message: error.toString(), error: true);
        },
        loading: () {},
      );
    });
    return AnimatedContainer(
      duration: Duration(seconds: 2),
      decoration: songProvider == null
          ? null
          : BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(int.parse("ff${songProvider.value!.color}", radix: 16)),
                  AppPallete.transparentColor,
                ],
                stops: [0.0, 0.3],
              ),
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 200,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: recentlyPlayedSongs.length,
              itemBuilder: (context, index) {
                final song = recentlyPlayedSongs[index];
                return GestureDetector(
                  onTap: () {
                    songNotifier.updateSong(song);
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                          child: Image.network(
                            song.thumbnailURL,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.broken_image);
                            },
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          song.songName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Latest Today",
              style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
            ),
          ),
          ref
              .watch(getAllSongProvider)
              .when(
                data: (song) {
                  return SizedBox(
                    height: 260,
                    child: ListView.builder(
                      itemCount: song.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: () {
                            ref
                                .read(currentSongProvider.notifier)
                                .updateSong(song[index]);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 180,
                                  width: 180,
                                  child: Image.network(
                                    song[index].thumbnailURL,
                                    errorBuilder: (context, error, st) {
                                      return const Icon(
                                        Icons.broken_image_sharp,
                                      );
                                    },
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  song[index].songName,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(song[index].artistName),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                },
                error: (error, st) {
                  return Center(child: Text(error.toString()));
                },
                loading: () {
                  return Loader();
                },
              ),
        ],
      ),
    );
  }
}
