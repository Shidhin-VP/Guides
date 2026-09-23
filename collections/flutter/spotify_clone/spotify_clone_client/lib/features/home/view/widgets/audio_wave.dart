import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:spotify_clone_client/core/theme/app_pallete.dart';

class AudioWave extends StatefulWidget {
  final String path;
  const AudioWave({super.key, required this.path});

  @override
  State<AudioWave> createState() => _AudioWaveState();
}

class _AudioWaveState extends State<AudioWave> {
  final PlayerController playerController = PlayerController();

  @override
  void initState() {
    super.initState();
    initPlayerController();
  }

  @override
  void dispose() {
    playerController.dispose();
    super.dispose();
  }

  void initPlayerController() async {
    await playerController.preparePlayer(
      path: widget.path,
      shouldExtractWaveform: true,
    );
  }

  Future<void> playAndPause() async {
    print(playerController.playerState);
    if (!playerController.playerState.isPlaying) {
      print("INside this");
      await playerController.startPlayer();
    } else if (!playerController.playerState.isPaused) {
      await playerController.pausePlayer();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("Path: ${widget.path}");
    return Row(
      children: [
        IconButton(
          onPressed: playAndPause,
          icon: Icon(
            (playerController.playerState.isPlaying)
                ? Icons.pause
                : Icons.play_arrow,
          ),
        ),
        Expanded(
          child: AudioFileWaveforms(
            decoration: BoxDecoration(
            ),
            playerWaveStyle: PlayerWaveStyle(
              fixedWaveColor: AppPallete.borderColor,
              liveWaveColor: AppPallete.gradient2,
              spacing: 8, 
              showSeekLine: false
            ),
            size: Size(double.infinity, 50),
            playerController: playerController,
          ),
        ),
      ],
    );
  }
}
