import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Membuat sebuah provider bernama commonFirebaseStorageRepositoryProvider
// yang akan mengembalikan sebuah instance dari CommonFirebaseStorageRepository
final commonFirebaseStorageRepositoryProvider = Provider(
  (ref) => CommonFirebaseStorageRepository(
    firebaseStorage: FirebaseStorage.instance,
  ),
);

// Membuat sebuah class CommonFirebaseStorageRepository
class CommonFirebaseStorageRepository {
  final FirebaseStorage firebaseStorage;

  // Constructor class CommonFirebaseStorageRepository
  CommonFirebaseStorageRepository({
    required this.firebaseStorage,
  });

  // Fungsi untuk menyimpan file ke Firebase Storage
  Future<String> storeFileToFirebase(String ref, File file) async {
    // Membuat instance dari UploadTask yang merepresentasikan task untuk mengunggah file ke Firebase Storage
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);

    // Menunggu task upload selesai dan mendapatkan TaskSnapshot setelah upload selesai
    TaskSnapshot snap = await uploadTask;

    // Mendapatkan URL unduhan file dari task snapshot yang telah selesai diupload
    String downloadUrl = await snap.ref.getDownloadURL();

    // Mengembalikan URL unduhan file yang telah diupload ke Firebase Storage
    return downloadUrl;
  }
}
