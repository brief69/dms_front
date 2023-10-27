

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bennu_app/models/other_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final userViewModelProvider = StateNotifierProvider<UserViewModel, User>((ref) {
  return UserViewModel();
});

class UserViewModel extends StateNotifier<User> {
  UserViewModel() : super(User(uid: '', username: '', iconURL: '', following: [], followers: [], posts: []));

  Future<void> fetchUserData(String uid) async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final data = doc.data() as Map<String, dynamic>;

    state = User(
      uid: uid,
      username: data['username'],
      iconURL: data['iconURL'],
      following: List<String>.from(data['following']),
      followers: List<String>.from(data['followers']),
      posts: List<String>.from(data['posts']),
    );
  }
}
