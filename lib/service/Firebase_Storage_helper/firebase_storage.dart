import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FireBaseStoragehelper {
  static FireBaseStoragehelper instance = FireBaseStoragehelper();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  //function for upload image to firebase
  Future<String> uploadUserImage(File image) async {
    String userid = FirebaseAuth.instance.currentUser!.uid;
    TaskSnapshot taskSnapshot = await _storage.ref(userid).putFile(image);

    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    return imageUrl;
  }


  

}
