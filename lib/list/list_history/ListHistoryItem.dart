import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../database/HistoryRepository.dart';
import '../detail_word/DetailWord.dart';

class CardHistoryItem extends ConsumerWidget {

  final String word;

  const CardHistoryItem({required this.word});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final histRepo = ref.read(historyRepository);

    return GridTile(
        child: Container(
          decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 0.5)),
          child: GestureDetector(
            onTap: () {
              showModalBottomSheet<void>(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return DetailWord(word: word, listWords: histRepo.history.map((e) => e.word).toList(),);
                  });
            },
            child: Card(
                color: Colors.white,
                borderOnForeground: false,
                elevation: 0,
                shadowColor: Colors.transparent,
                child: Center(
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(word),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: (){
                            histRepo.removeFavorite(word);
                          },
                          child: const Icon(Icons.delete),)
                      ]),
                )),
          )
        ));
  }
}