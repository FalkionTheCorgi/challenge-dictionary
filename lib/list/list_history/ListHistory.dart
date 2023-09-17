import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truckpag_challenge/database/HistoryRepository.dart';
import 'package:truckpag_challenge/list/list_history/ListHistoryItem.dart';

class ListHistory extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ListHistoryState();
}

class ListHistoryState extends ConsumerState<ListHistory> {

  @override
  Widget build(BuildContext context) {

    final histRepo = ref.watch(historyRepository);

    // TODO: implement build
    return Padding(
        padding: const EdgeInsets.all(8.0),
      child: histRepo.history.isEmpty

          ? const Center(
            child: Text('No History Registered'),
          )

          : GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
          crossAxisCount: 3,
          // Generate 100 widgets that display their index in the List.
          children: [
            for(var element in histRepo.history) CardHistoryItem(word: element.word)
          ]),
    );
  }

}