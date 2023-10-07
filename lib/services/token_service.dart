



import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/berry_token.dart';

Future<void> mintBerryToken(DocumentSnapshot<Map<String, dynamic>> post) async {
  final berryToken = BerryToken(
    address: PublicKey, // ぼく(発行者の)公開鍵
    supply: BigInt.from(0), // トークンの初期供給量は 0
    decimals: 9, // 9 decimals for example
    mintAuthority: PrivateKey, // ぼく(発行者の)秘密鍵、どのように取得しようか？
    isInitialized: true, // トークンは初期化済み
    freezeAuthority: null, // 現在は凍結権限はなし
  );

  // ユーザーが投稿を行うたびに 0.3 ベリートークンを発行
  final amountToMint = BigInt.from(3) * BigInt.from(10).pow(17); // 0.3 ベリートークン
  berryToken.mintToken(
    destination: PublicKey.fromBase58(userAddress), // ユーザーの公開鍵
    amount: amountToMint, 
    mintAuthority: PrivateKey, // ぼく(発行者の)秘密鍵、どのように取得しようか？
  );

  // トークンの発行上限は 3300 万ベリー
  if (berryToken.supply + amountToMint > BigInt.from(33000000) * BigInt.from(10).pow(9)) {
    throw Exception('Token supply limit exceeded');
  }
}
