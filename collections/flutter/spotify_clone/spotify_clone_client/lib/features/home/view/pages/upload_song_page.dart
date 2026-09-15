import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone_client/core/widgets/custom_field.dart';

class UploadSongPage extends ConsumerStatefulWidget {
  const new({super.key});

  @override
  ConsumerState<UploadSongPage> createState() => _UploadSongPageState();
}

class _UploadSongPageState extends ConsumerState<UploadSongPage> {
  TextEditingController pickSongController = TextEditingController();
  TextEditingController artistController = TextEditingController();
  TextEditingController songNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Upload Songs"), centerTitle: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.folder_open)),
          Text("Select the thumbnail for your song"),
          SizedBox(height: 20),
          CustomTextField(
            hintText: "pick Song",
            controller: pickSongController,
          ),
          SizedBox(height: 15),
          CustomTextField(hintText: "Artist", controller: artistController),
          SizedBox(height: 15),
          CustomTextField(
            hintText: "Song Name",
            controller: songNameController,
          ),
          Text("Select Color")
        ],
      ),
    );
  }
}
