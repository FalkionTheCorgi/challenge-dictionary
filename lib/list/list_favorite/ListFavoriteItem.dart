import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../database/FavoriteRepository.dart';
import '../detail_word/DetailWord.dart';

class CardFavoriteItem extends ConsumerWidget {

  final String word;

  const CardFavoriteItem({super.key, required this.word});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final favorite = ref.read(favoriteRepository);

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
                    return DetailWord(word: word, listWords: favorite.favorite.map((e) => e.word).toList(),);
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
                                favorite.removeFavorite(word);
                            },
                            child: const Icon(Icons.delete),)
                      ],
                )),
          )
        )));
  }
}