import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

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

class RiverpodScreen extends StatefulWidget {
  const RiverpodScreen({Key? key}) : super(key: key);

  @override
  State<RiverpodScreen> createState() => _RiverpodScreenState();
}

class _RiverpodScreenState extends State<RiverpodScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riverpod'),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: GetIt.I.get<DataNetwork>().getFruitList(),
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
                        child: ListView(
                          children: GetIt.I
                              .get<DataNetwork>()
                              .fl
                              .map((element) {
                            return Card(
                              child: ListTile(
                                title: Text(element.name),
                                subtitle: Text('Цена: ${element.cost} руб.'),
                                trailing: Consumer(
                                  builder: (context, ref, _) => TextButton(
                                    onPressed: () {
                                      ref.read(basketProvider.notifier).updateInBasket(element.id, element.name, element.cost);
                                      ref.read(listProvider.notifier).getList();
                                      ref.read(countProvider.notifier).getCount();
                                      ref.read(selectProvider.notifier).checkSelect(element.id);
                                    },
                                    child: ref.watch(selectProvider)
                                          ? const Text(
                                              'Удалить',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            )
                                          : const Text(
                                              'Добавить',
                                              style: TextStyle(
                                                  color: Colors.green),
                                            ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
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

  @override
  bool get wantKeepAlive => true;
}
