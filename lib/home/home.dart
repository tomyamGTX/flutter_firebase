import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FirebaseAuth.instance.currentUser!.photoURL == null ||
                  FirebaseAuth.instance.currentUser!.photoURL!.isEmpty
              ? ElevatedButton(
                  onPressed: _uploadImage, child: Text("Upload image"))
              : CircleAvatar(
                  radius: 100,
                  backgroundImage: NetworkImage(
                      FirebaseAuth.instance.currentUser!.photoURL!))
        ],
      ),
    ));
  }

  Future<void> _uploadImage() async {
    /// pick image from gallery
    final XFile? media = await _picker.pickMedia();
    var imageToUpload = await media!.readAsBytes();
    var userId = FirebaseAuth.instance.currentUser!.uid;
    ///upload image
    await FirebaseStorage.instance
        .ref('profile/$userId')
        .putData(imageToUpload);
    var url =
        await FirebaseStorage.instance.ref('profile/$userId').getDownloadURL();
    ///update previous image url to user photo url
    FirebaseAuth.instance.currentUser!.updatePhotoURL(url);
  }
}
