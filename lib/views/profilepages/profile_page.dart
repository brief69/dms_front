
// profile_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'settings_page.dart';

class ProfilePage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: _firestore.collection('users').doc('userId').snapshots(), // 'userId'を適切に置き換えてください
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          var userData = snapshot.data;
          return Column(
            children: [
              // User Icon, Username, and Rating
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Assume openImagePicker() is a function to allow users to pick and upload a new icon
                      openImagePicker(context, userData);
                    },
                    child: Image.network(userData?['userIcon'] ?? ''),
                  ),
                  Column(
                    children: [
                      Text(userData?['userName'] ?? ''),
                      StarRating(rating: userData?['userRating'] ?? 0),
                    ],
                  ),
                ],
              ),
              // Solana Address QR and Public Key
              QrImage(
                data: userData?['solanaAddress'] ?? '',// TODO: これを解決するにはまず、solanaAddressを取得する必要がある
              ),
              InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: userData?['solanaAddress'] ?? ''));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Address copied!')),
                  );
                },
                child: Text(userData?['solanaAddress'] ?? ''),
              ),
              // Tabs for History and Wallet
              DefaultTabController(
                length: 6,
                child: Column(
                  children: [
                    const TabBar(
                      tabs: [
                        Tab(text: 'Post'),
                        Tab(text: 'Like'),
                        Tab(text: 'Comment'),
                        Tab(text: 'Purchase'),
                        Tab(text: 'Balance'),
                        Tab(text: 'Transaction'),
                      ],
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          buildGridView(userData?['postHistory']),
                          buildGridView(userData?['likeHistory']),
                          buildGridView(userData?['commentHistory']),
                          buildGridView(userData?['purchaseHistory']),
                          // Balance and Transaction can have different implementations
                          buildBalanceView(userData),
                          buildTransactionView(userData),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  GridView buildGridView(List<dynamic>? historyData) {
    return GridView.builder(
      itemCount: historyData?.length ?? 0,
      itemBuilder: (context, index) {
        return Image.network(historyData?[index] ?? '');
      }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      )
    );
  }

  Widget buildBalanceView(dynamic userData) {
    // You can have a custom widget for showing the balance
    return Column(
      children: [
        Text("Token: ${userData?['tokenBalance']}"),
        Text("Currency: ${userData?['currencyBalance']}"),
      ],
    );
  }

  ListView buildTransactionView(dynamic userData) {
    List<dynamic>? transactions = userData?['transactions'];
    return ListView.builder(
      itemCount: transactions?.length ?? 0,
      itemBuilder: (context, index) {
        var transaction = transactions?[index];
        return ListTile(
          title: Text(transaction?['type'] ?? ''),
          subtitle: Text(transaction?['amount'] ?? ''),
          // Additional details can be added
        );
      },
    );
  }

  void openImagePicker(BuildContext context, dynamic userData) {
    // Implementation for opening image picker and updating Firestore
  }
}

class StarRating extends StatelessWidget {
  final int rating;

  const StarRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(5, (index) => 
        Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.yellow,
        )
      ),
    );
  }
}
