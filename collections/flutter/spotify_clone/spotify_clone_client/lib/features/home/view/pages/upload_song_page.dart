import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone_client/core/theme/app_pallete.dart';
import 'package:spotify_clone_client/core/utils/general_app_status.dart';
import 'package:spotify_clone_client/core/utils/utils.dart';
import 'package:spotify_clone_client/core/widgets/custom_field.dart';
import 'package:spotify_clone_client/core/widgets/loader.dart';
import 'package:spotify_clone_client/features/home/view/pages/home_page.dart';
import 'package:spotify_clone_client/features/home/view/widgets/audio_wave.dart';
import 'package:spotify_clone_client/features/home/viewmodel/home_viewmodel.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<UploadSongPage> createState() => _UploadSongPageState();
}

class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  TextEditingController artistController = TextEditingController();
  TextEditingController songNameController = TextEditingController();
  Color selectedColor = AppPallete.cardColor;
  File? selectedAudio;
  File? selectedImage;

  void selectAudio() async {
    final audioPath = await pickAudio();
    if (audioPath != null) {
      setState(() {
        selectedAudio = audioPath;
      });
    }
  }

  void selectImage() async {
    final imagePath = await pickImage();
    if (imagePath != null) {
      setState(() {
        selectedImage = imagePath;
      });
    }
  }

  String getSongName(File filePath) {
    String fileString = filePath.path;
    int initialIndex = fileString.lastIndexOf("/");
    int endIndex = fileString.lastIndexOf(".");
    return fileString.substring(initialIndex, endIndex);
  }

  @override
  void dispose() {
    artistController.dispose();
    songNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      homeViewModelProvider.select((val) => val?.isLoading == true),
    );
    ref.listen(homeViewModelProvider, (_, next) {
      next?.when(
        data: (data) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
        error: (error, st) {
          showAppStatus(context, message: error.toString(), error: true);
        },
        loading: () {},
      );
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Songs"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (selectedAudio != null && selectedImage != null) {
                ref
                    .read(homeViewModelProvider.notifier)
                    .uploadSong(
                      selectedAudio!,
                      selectedImage!,
                      songNameController.text,
                      artistController.text,
                      selectedColor.hex,
                    );
              }
            },
            icon: Icon(Icons.check),
          ),
        ],
      ),
      body: isLoading
          ? Loader()
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: selectImage,
                      child: selectedImage != null
                          ? SizedBox(
                              height: 150,
                              width: double.infinity,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(
                                  selectedImage!,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                          : DottedBorder(
                              options: RectDottedBorderOptions(
                                color: AppPallete.borderColor,
                                dashPattern: [10, 4],
                                strokeCap: StrokeCap.round,
                              ),
                              child: const SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.folder_open),
                                    Text(
                                      "Select the thumbnail for Your Song",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(height: 40),
                    selectedAudio != null
                        ? AudioWave(path: selectedAudio!.path)
                        : CustomTextField(
                            hintText: "Pick Song",
                            readOnly: true,
                            onTap: selectAudio,
                          ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      hintText: "Artist",
                      controller: artistController,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      hintText: "Song Name",
                      controller: songNameController,
                    ),
                    // const SizedBox(height: 20),
                    ColorPicker(
                      heading: Text("Select Color"),
                      pickersEnabled: {ColorPickerType.wheel: true},
                      color: selectedColor,
                      onColorChanged: (Color color) {
                        setState(() {
                          selectedColor = color;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
