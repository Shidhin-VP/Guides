import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<File?> pickAudio() async {
  try {
    final filePickerRes = await FilePicker.pickFiles(type: FileType.audio);
    if (filePickerRes != null && filePickerRes.isNotEmpty) {
      return File(filePickerRes.first.xFile.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}

Future<File?> pickImage() async {
  try {
    final filePickerRes = await FilePickerPlatform.instance.pickFiles(
      type: FileType.image,
    );
    if (filePickerRes != null && filePickerRes.isNotEmpty) {
      return File(filePickerRes.first.xFile.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}
