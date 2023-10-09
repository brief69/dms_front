

import 'package:bennu_app/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // エラーや成功の状態を保持するための変数
  bool _isUploading = false;
  String? _errorMessage;

  bool get isUploading => _isUploading;
  String? get errorMessage => _errorMessage;

  Future<List<Post>> fetchPosts() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('posts').get();

      List<Post> posts = snapshot.docs.map((doc) {
        return PostFirestore.fromFirestore(doc);
      }).toList();

      return posts;
    } catch (e) {
      ("Error fetching posts: $e");
      throw FetchDataException("Error fetching posts from Firestore: $e");
    }
  }

  Future<void> uploadPost(Post post) async {
    try {
      _isUploading = true;
      notifyListeners();

      await _firestore.collection('posts').add(post.toFirestore());

      _isUploading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = "Error uploading post to Firestore: $e";
      _isUploading = false;
      notifyListeners();
      throw UploadDataException(_errorMessage!);
    }
  }

  static void updateShouldNotify(PostViewModel post) {}
}

class FetchDataException implements Exception {
  final String message;
  FetchDataException(this.message);
}

class UploadDataException implements Exception {
  final String message;
  UploadDataException(this.message);
}
