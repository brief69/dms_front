


import 'package:flutter/foundation.dart';
import 'package:bennu_app/models//logout_model.dart';

class LogoutViewModel extends ChangeNotifier {
  final LogoutModel _logoutModel;

  LogoutViewModel(this._logoutModel);

  Future<void> logOut() async {
    try {
      await _logoutModel.performLogout();
      notifyListeners();
    } catch (e) {
      // TODO: #6 エラーハンドリング
    }
  }
}
