

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bennu_app/viewmodels/user_viewmodel.dart';
import 'package:bennu_app/views/profilepages/followers_page.dart';
import 'package:bennu_app/views/profilepages/following_page.dart';

class UserPage extends ConsumerWidget {
  final String uid;  // このIDをもとにFirestoreからデータを取得

  const UserPage({super.key, required this.uid});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userViewModelProvider);
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Text(user.userName, style: const TextStyle(color: Colors.white)),
            Image.network(user.userIcon),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FollowersPage(uid: uid)));
              },
              child: Text("Followers: ${user.followerCount}", style: const TextStyle(color: Colors.white)),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => FollowingPage(uid: uid)));
              },
              child: Text("Following: ${user.followingCount}", style: const TextStyle(color: Colors.white)),
            ),
            const Text("History", style: TextStyle(color: Colors.white)),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                itemCount: user.postHistory.length,
                itemBuilder: (context, index) {
                  return Image.network(user.postHistory[index]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

// TODO: このページは他のユーザーから見るページだが、他のユーザーが見るページは同じでいい。
// 閲覧のみか、データ操作が可能かどうかに違いしかないので、後々にprofilepageを参照する。
// 


