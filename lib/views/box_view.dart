

// box_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/box_viewmodel.dart';

class BoxView extends ConsumerWidget {
  const BoxView({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final boxItems = ref.watch(boxProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("カート"), // TODO #2:タイトルは今後考えるかな
      ),
      body: ListView.builder(
        itemCount: boxItems.length,
        itemBuilder: (ctx, index) {
          final product = boxItems[index];
          return ListTile(
            leading: Image.network(product.imageUrl),
            title: Text(product.name),
            subtitle: Text("¥${product.totalPrice.toStringAsFixed(2)}"),
            trailing: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () {
                    ref.read(boxProvider.notifier).updateQuantity(product.id, -1);
                  },
                ),
                Text("${product.quantity}"),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    ref.read(boxProvider.notifier).updateQuantity(product.id, 1);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    ref.read(boxProvider.notifier).removeProduct(product.id);
                  },
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("合計: ¥${ref.read(boxProvider.notifier).totalAmount.toStringAsFixed(2)}"),
        ),
      ),
    );
  }
}

// box_view.dartは、商品のカートのページ
// カートのページは、アプリのメインのタブバーの右側のタブに表示されており、
// カートタブをタップすると、カートの中身が表示される
// カートの中身は、商品の画像、商品名、商品の値段、商品の個数、商品の合計金額、商品の削除ボタンが表示される
// 商品の削除ボタンを押すと、その商品がカートから削除される
// カートの中身の合計金額は、カートの中身の商品の合計金額の合計金額を表示する
// 一つ一つの商品は、Listviewで表示する
// 商品の個数は、プラスボタンとマイナスボタンで増減できる
// 商品の個数を増減すると、商品の合計金額が変わる
// 商品の個数を増減すると、カートの中身の合計金額が変わる