

// 既存のimport文に以下を追加
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RelayPostPage extends StatefulWidget {
  const RelayPostPage({super.key});

  @override
  RelayPostPageState createState() => RelayPostPageState();
}

class RelayPostPageState extends State<RelayPostPage> {
  List<DocumentSnapshot>? _purchaseHistory; // 購入履歴データを保持するリスト

  @override
  void initState() {
    super.initState();
    _fetchPurchaseHistory();
  }

  _fetchPurchaseHistory() async {
    // ここでは仮に'purchaseHistory'というコレクションから購入履歴を取得するとします。
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('purchaseHistory').get();
    setState(() {
      _purchaseHistory = snapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add RePost'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () {
                // モーダルで購入履歴を表示する
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      itemCount: _purchaseHistory?.length ?? 0,
                      itemBuilder: (context, index) {
                        // ここで_mediaUrlはFirestoreの構造に依存するので、適切なフィールド名に変更してください。
                        String mediaUrl = _purchaseHistory![index]['mediaUrl'];
                        return GestureDetector(
                          onTap: () {
                            // 選択したアイテムの処理を実装する
                            Navigator.pop(context); // モーダルを閉じる
                          },
                          child: Image.network(mediaUrl), // 画像を表示する
                        );
                      },
                    );
                  },
                );
              },
              child: const Text('購入履歴を選択'),
            ),
            const TextField(
              decoration: InputDecoration(hintText: '変わった点を記載する'),
            ),
            const SizedBox(height: 10),
            const TextField(
              decoration: InputDecoration(hintText: '異なる点を説明する'),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // Relayボタンの処理を実装
              },
              child: const Text('Relay'),
            ),
          ],
        ),
      ),
    );
  }
}

