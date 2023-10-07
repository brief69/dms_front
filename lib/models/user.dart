

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String id;
  final String name;
  late final String userIcon;
  final int userRating;
  final String solanaAddress;
  final List<dynamic> postHistory;
  

  User({
    required this.id,
    required this.name,
    required this.userIcon,
    required this.userRating,
    required this.solanaAddress,
    required this.postHistory, required String email, required publicKey, 
  });

  // FirestoreのDocumentSnapshotからUserモデルに変換するためのファクトリメソッド
  factory User.fromDocument(DocumentSnapshot doc) {
    return User(
      id: doc.id,
      name: doc['userName'],
      userIcon: doc['userIcon'],
      userRating: doc['userRating'],
      solanaAddress: doc['solanaAddress'],
      postHistory: doc['postHistory'], 
      email: '', publicKey: null, 
      
    );
  }

  get email => null;

  get publicKey => null;
  // ... other properties and methods ...

  Future<bool> deleteCurrentUser() async {
    // implementation to delete the current user
    return true; // return true if the deletion was successful
  }
}
  get email => null;

  get publicKey => null;
