

import 'package:bennu_app/services/auth_service.dart';
import 'package:bennu_app/services/wallet_service.dart';
import 'package:bennu_app/services/firestore_service.dart';
import 'package:bennu_app/models/user.dart';

class RegistrationViewModel {
  final AuthService _authService = AuthService();
  final WalletService _walletService = WalletService();
  final FirestoreService _firestoreService = FirestoreService();

  Future<void> registerAndCreateWallet(String email) async {
    final userId = await _authService.registerWithEmail(email);
    if (userId != null) {
      final wallet = await _walletService.createWallet();

      // passkeysを使用して秘密キーを保存...

      final user = User(id: userId, email: email, publicKey: wallet.publicKey, name: '', postHistory: [], solanaAddress: '', userIcon: '', userRating: 0);
      await _firestoreService.storeUser(user);
    }
  }
}
