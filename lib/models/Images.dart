import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

FirebaseStorage storage = FirebaseStorage.instance;


printUrl() async {
}

Future<Map<String, dynamic>> getAvatar(String modelId) async{
  List<Map<String, dynamic>> files = [];

  final ListResult result = await storage.ref().list();
  final List<Reference> allFiles = result.items;

  await Future.forEach<Reference>(allFiles, (file) async {
    final String fileUrl = await file.getDownloadURL();
    final FullMetadata fileMeta = await file.getMetadata();
    files.add({
      "url": fileUrl,
      "path": file.fullPath,
      "uploaded_by": fileMeta.customMetadata['uploaded_by'],
      "description": fileMeta.customMetadata['description']
    });
  });

  return files[files.length-1];
}



