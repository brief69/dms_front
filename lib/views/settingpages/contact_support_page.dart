

// contact_support_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ContactPage extends StatefulWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  ContactPageState createState() => ContactPageState();
}

class ContactPageState extends State<ContactPage> {
  final contactController = TextEditingController();

  @override
  void dispose() {
    contactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<SettingsViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('CONTACT', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 90, 0, 0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('あなたのフィードバック:', style: TextStyle(color: Colors.black, fontSize: 16)),
            const SizedBox(height: 8.0),
            Expanded(
              child: TextField(
                controller: contactController,
                maxLines: 10,
                decoration: const InputDecoration(
                  hintText: 'こちらにフィードバックを入力してください...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 12.0),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await viewModel.sendFeedback(contactController.text);
                  // TODO: #13 成功した場合の処理を追加
                },
                child: const Text('送信'),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: viewModel.contactViaTwitter,
                child: const Text('Twitterで問い合わせる'),
              ),
            )
          ],
        )
      ),
    );
  }
}

class SettingsViewModel {
  get contactViaTwitter => null;

  sendFeedback(String text) {}
}
