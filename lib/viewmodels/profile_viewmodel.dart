

import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? _user;
  User? get user => _user;

  // ユーザーデータをロード
  Future<void> loadUserData(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
      _user = User.fromDocument(doc);
      notifyListeners();
    } catch (e) {
      ("Error loading user data: $e");
      // エラーハンドリングを適切に行う必要があります
    }
  }

  // ユーザーアイコンを更新
  Future<void> updateUserIcon(String userId, String newIconUrl) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'userIcon': newIconUrl,
      });
      _user?.userIcon = newIconUrl;
      notifyListeners();
    } catch (e) {
      ("Error updating user icon: $e");
      // ここでエラーハンドリングを適切に行う必要があります
    }
  }

  fetchProfileDetails() {}
}
