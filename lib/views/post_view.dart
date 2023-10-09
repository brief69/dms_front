

import 'dart:io';

import 'package:bennu_app/models/post.dart';
import 'package:bennu_app/viewmodels/post_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  PostViewState createState() => PostViewState();
}

class PostViewState extends State<PostView> {
  final ImagePicker _picker = ImagePicker();
  List<XFile?> _selectedMedias = [];
  String _caption = "";

  pickMediaFromGallery() async {
    List<XFile?> medias = await _picker.pickMultiImage();
    if (medias.length <= 6) {
      setState(() {
        _selectedMedias = medias;
      });
      // UI上で表示されるプレビュー
    }
  }

  captureMediaWithCamera() async {
    XFile? media = await _picker.pickVideo(source: ImageSource.camera, maxDuration: const Duration(minutes: 1));
    if (media != null) {
      setState(() {
        _selectedMedias = [media];
      });
    }
  }

  Future<String?> uploadMediaToFirebase(XFile media) async {
    XFile file = File(media.path) as XFile;
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("uploads/${DateTime.now().millisecondsSinceEpoch}");
    UploadTask uploadTask = ref.putFile(file as File);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => {});
    String? downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadMediaAndCaption() async {
    List<String> mediaUrls = [];
    for (XFile? media in _selectedMedias) {
      if (media != null) {
        String? mediaUrl = await uploadMediaToFirebase(media);
        if (mediaUrl != null) mediaUrls.add(mediaUrl);
      }
    }

    // Create post object
    final post = Post(
      caption: _caption,
      // 他のフィールドも適切に設定
      mediaUrls: mediaUrls,
      postDate: DateTime.now(), 
      userIcon: '',
      likesCount: 0,
      commentsCount: 0,
      relayCount: 0,
      shareCount: 0,
      buyCount: 0,
      price: 0,
      stock: 0,
    );

    // Firestoreに投稿を保存
    FirebaseFirestore.instance.collection('posts').add(post.toMap());
    PostViewModel.updateShouldNotify(post as PostViewModel); // Assuming that the ViewModel has the correct methods
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ..._selectedMedias.map((media) => Image.file(File(media!.path))).toList(),
          TextField(
            onChanged: (value) => _caption = value,
            decoration: const InputDecoration(hintText: "Caption..."),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: uploadMediaAndCaption,
        child: const Icon(Icons.upload),
      ),
    );
  }
}
