import "dart:io";

import "package:firebase_storage/firebase_storage.dart";
import "package:path_provider/path_provider.dart";

class UpLoadService {
  final StorageRef = FirebaseStorage.instance.ref();

// Check this function in the firebase documentation for storage upload file
  Future<String> upLoadFile(
      String filePath, String fileName, String categoryName) async {
    final file = File(filePath);

// Create the file metadata
    final metadata = SettableMetadata(contentType: "image/jpeg");

// Create a reference to the Firebase Storage bucket
    final storageRef = FirebaseStorage.instance.ref();

// Upload file and metadata to the path 'images/mountains.jpg'
    final uploadTask = storageRef
        .child("images/$categoryName/$fileName")
        .putFile(file, metadata);

// Listen for state changes, errors, and completion of the upload.
    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) {
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress =
              100.0 * (taskSnapshot.bytesTransferred / taskSnapshot.totalBytes);
          print("Upload is $progress% complete.");
          break;
        case TaskState.paused:
          print("Upload is paused.");
          break;
        case TaskState.canceled:
          print("Upload was canceled");
          break;
        case TaskState.error:
          print("Upload has an error ij  ");
          // Handle unsuccessful uploads
          break;
        case TaskState.success:
          // Handle successful uploads on complete
          // ...

          break;
      }
    });

    // to get download url of uploaded file to use for creating the model sneaker
    return await uploadTask.snapshot.ref.getDownloadURL();
  }
}
