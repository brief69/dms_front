



import 'package:bennu_app/models/user.dart';

class DeleteAccountViewModel {
  final _userModel = 
    User(
      id: '',
      name: '', 
      userIcon: '', 
      userRating: 0, 
      solanaAddress: '', 
      postHistory: [], 
      email: '', 
      publicKey: null
    );

  Future<bool> deleteAccount() async {
    return await _userModel.deleteCurrentUser();
  }
}
