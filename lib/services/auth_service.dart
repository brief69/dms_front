

import 'package:passkeys/passkey_auth.dart';

class AuthService {
  final PasskeyAuth _auth = PasskeyAuth();// TODO: ここでPasskeyAuthをインスタンス化エンドポイントを指定する

  Future<String?> registerWithEmail(String email) async {
    final response = await _auth.registerWithEmail(email);
    if (response != null) {
      return response.userId;
    }
    return null;
  }
}
