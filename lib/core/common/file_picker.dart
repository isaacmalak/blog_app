import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<File?> pickImage() async {
  try {
    final xFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (xFile != null) {
      return File(xFile.files.single.path!);
    }
    return null;
  } catch (e) {
    log(e.toString());
    return null;
  }
}
