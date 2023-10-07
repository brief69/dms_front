

// rules_page.dart
import 'package:flutter/material.dart';

class RulesPage extends StatelessWidget {
  const RulesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bennu Rules', style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromARGB(255, 90, 0, 0),
          bottom: const TabBar(
            tabs: [
            Tab(text: 'Bennu User Rules'),
              Tab(text: 'Bennu Management Rules'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            UserRulesTab(),
            ManagementRulesTab(),
          ],
        ),
      ),
    );
  }
}

class UserRulesTab extends StatelessWidget {
  const UserRulesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(
          title: Text('最初のルールは、ルールがないこと'),
        ),
        ListTile(
          title: Text('実際に新品かどうかよりも、新品に見えるかどうかが重要だったりする'),
        ),
        ListTile(
          title: Text('このアプリは、いわば取引の究極の民主制を保持しています。'),
        ),
        ListTile(
          title: Text('逆にいうと、商品を売る人も商品を買う人も、自分の判断で取引を行うことができるということです。'),
        ),
        ListTile(
          title: Text(''),
        ),
        ListTile(
          title: Text(''),
        ),
        ListTile(
          title: Text(''),
        ),
        ListTile(
          title: Text(''),
        ),
        ListTile(
          title: Text(''),
        ),
      ],
    );
  }
}

class ManagementRulesTab extends StatelessWidget {
  const ManagementRulesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(
          title: Text('運営ルール1'),
        ),
        ListTile(
          title: Text('運営ルール2'),
        ),
        ListTile(
          title: Text('運営ルール3'),
        ),
        ListTile(
          title: Text('運営ルール4'),
        ),
        ListTile(
          title: Text('運営ルール5'),
        ),
        ListTile(
          title: Text('運営ルール6'),
        ),
        ListTile(
          title: Text('運営ルール7'),
        ),
        ListTile(
          title: Text('運営ルール8'),
        ),
        ListTile(
          title: Text('運営ルール9'),
        ),
      ],
    );
  }
}


// 自由で民衆的ということは、特定の誰かの一方的で複雑な規制によって妨げられないということでもあるが、自分で責任を持つということでもあります。
// 例えば、法律や消費生活センター、警察や裁判所、役所、規制委員会などは、一定の規制を行い、それによって取引を行う人々の安全を守っているのは、
// それらの機関が存在すること意味があり、抑止力として機能しているからです。
// しかしながら、これらの機関とのやりとりを異sなければらならなくなったことのある人の多くは身をもって知っている方も多いと思いますが、
// これらの機関や組織は、何かあったときに何かしら動いてくれるものではないのです。
// 人によっては、何かあったときに、何かしら動いてくれるものだと信じていた人たちにとっては、これらのこれらの抑止機関によって、
// さらなる追い討ちをかけられることになり、心身の健康を著しく損ない何も信用できなくなった人も多いでしょう。

// 例えば、あなたが、ある商品を買ったとします。
// その商品は、あなたが思っていたものとは違っていたり、壊れていたり、使えなかったり、
// あるいは、あなたが思っていたよりも、ずっとずっと安かったり、高かったりすることがあります。
// そんなとき、あなたは、その商品を買ったお店に、その商品を返品したいと言います。
// そのとき、お店の人は、あなたに、返品はできないと言うかもしれません。
// あなたは、そのとき、お店の人に、返品できないのはおかしいと言うかもしれません。
// お店の人は、あなたに、返品できないのは、お店のルールだからだと言うかもしれません。
// あなたは、そのとき、お店の人に、ルールはおかしいと言うかもしれません。
// 

