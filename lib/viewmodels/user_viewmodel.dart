

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bennu_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final userViewModelProvider = StateNotifierProvider<UserViewModel, User>((ref) {
  return UserViewModel();
});

class UserViewModel extends StateNotifier<User> {
  UserViewModel() : super(User(id: '', userIcon: '', userName: '', solanaAddress: '', postHistory: [], likesHistory: [], buyHistory: [], followingCount: , followerCount:, ));

  Future<void> fetchUserData(String uid) async {
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    final data = doc.data() as Map<String, dynamic>;

    state = User(
      id: 'id',
      userIcon: data['userIcon'],
      userName: data['userName'],
      postHistory: List<String>.from(data['postHistory']),
      likesHistory: List<String>.from(data['LikesHistory']),
      buyHistory: List<String>.from(data['buyhistory']), 
      solanaAddress: '', 
      followingCount: null, 
      followerCount: null
    );
  }
}
