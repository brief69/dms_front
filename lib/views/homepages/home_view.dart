
// home_view.dart
import 'package:bennu_app/models/media_model.dart';
import 'package:bennu_app/views/homepages/media_item_view.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bennu_app/viewmodels/media_viewmodel.dart';

class HomeView extends StatefulWidget {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  HomeView({Key? key}) : super(key: key);

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  // この関数を追加して、FirestoreからのデータをMediaViewModelに変換します
  MediaViewModel _createViewModelFromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> postData = doc.data() as Map<String, dynamic>;
    return MediaViewModel(
      MediaModel(
        firestore: widget.firestore,
        videoUrl: postData['media'] ?? '', // 仮に'media'というキーが存在して動画のURLを保持していると仮定します
        userIcon: postData['userIcon'] ?? '', // 'userIcon'というキーでユーザーアイコンのURLが来ると仮定します
        likes: postData['likes'] ?? 0,
        comments: postData['comments'] ?? 0,
        other: postData['other'] ?? '',
        buy: postData['Buy'] ?? 0,
        incart: postData['incart'] ?? 0,
        shares: postData['shares'] ?? 0,
        caption: postData['caption'] ?? '',
        stock: postData['stock'] ?? 0,
        price: postData['price'] ?? 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'オススメ'),
              Tab(text: 'フォロー'),
              Tab(text: '通知'),// 全ての通知を表示するページ(モーダル画面)
            ],
          ),
        ),
        body: StreamBuilder(
        stream: widget.firestore.collection('posts').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          List<MediaItemView> mediaItems = [];
          for (var doc in snapshot.data!.docs) {
            mediaItems.add(MediaItemView(
              caption: doc['caption'],
              itemlimit: doc['itemlimit'],
              postDate: doc['postDate'],
              likes: doc['likes'],
              comments: doc['comments'],
              shares: doc['shares'],
              purchases: doc['Buy'],
              media: doc['media'],
              boxin: doc['boxin'],
              viewModel: _createViewModelFromDocument(doc), // ここでFirestoreのドキュメントからViewModelを作成します
            ));
          }
          return ListView(children: mediaItems);
        },
      ),
      ),
    );
  }
}
