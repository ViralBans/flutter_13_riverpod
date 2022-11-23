import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import '../../business/functions.dart';
import '../../business/riverpod.dart';
import '../../data/services.dart';

final countProvider =
    StateNotifierProvider<CountState, int>((ref) => CountState());
final listProvider =
    StateNotifierProvider<ListState, List<String>>((ref) => ListState());
final basketProvider =
    StateNotifierProvider<BasketState, bool>((ref) => BasketState());
final selectProvider =
    StateNotifierProvider<SelectState, bool>((ref) => SelectState());

class RiverpodScreen extends StatelessWidget {
  const RiverpodScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod'),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: GetIt.I.get<DataNetwork>().getData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ConnectionState.done:
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Consumer(
                        builder: (context, ref, _) {
                          final count = ref.watch(countProvider);
                          final list = ref.watch(listProvider);

                          return Container(
                            width: double.infinity,
                            color: count == 0 ? Colors.red : Colors.green,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, bottom: 5.0),
                              child: count == 0
                                  ? const Text(
                                      'В корзине пусто',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : Text(
                                      'В корзине - $count продуктов ${list.toString()}',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                            ),
                          );
                        },
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) => Card(
                            child: ListTile(
                              title: Text(snapshot.data[index].name),
                              subtitle: Text(
                                  'Цена: ${snapshot.data[index].cost} руб.'),
                              trailing: Consumer(
                                builder: (context, ref, child) {
                                  ref.watch(selectProvider);

                                  return TextButton(
                                    onPressed: () {
                                      ref
                                          .read(selectProvider.notifier)
                                          .updateButton(
                                              snapshot.data[index].name);
                                      ref
                                          .read(basketProvider.notifier)
                                          .updateElementInBasket(
                                              snapshot.data[index].id,
                                              snapshot.data[index].name,
                                              snapshot.data[index].cost);
                                      ref.read(listProvider.notifier).getList();
                                      ref
                                          .read(countProvider.notifier)
                                          .getCount();
                                      print(GetIt.I.get<Basket>().select[snapshot.data[index].name]);
                                    },
                                    child: (GetIt.I.get<Basket>().select[snapshot.data[index].name] ?? !GetIt.I.get<Basket>().select[snapshot.data[index].name]!)
                                            ? const Text(
                                          'Удалить',
                                          style: TextStyle(color: Colors.red),
                                        )
                                            : const Text(
                                          'Добавить',
                                          style:
                                          TextStyle(color: Colors.green),
                                        ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              default:
                return const Center(child: Text('Нет данных с сервера!'));
            }
          },
        ),
      ),
    );
  }
}
