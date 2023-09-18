import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truckpag_challenge/database/FavoriteRepository.dart';
import 'package:truckpag_challenge/database/HistoryRepository.dart';

import '../detail_word/DetailWord.dart';

class CardWordItem extends ConsumerStatefulWidget {

  final String word;
  final List<String> words;

  CardWordItem({super.key, required this.word, required this.words});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => CardWordItemState();
}


class CardWordItemState extends ConsumerState<CardWordItem> {

  bool isFavorite = false;
  
  @override
  void initState() {
    final favRepo = ref.read(favoriteRepository);
    
    isFavorite = favRepo.favorite.where((element) => element.word == widget.word).isNotEmpty;
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final favorite = ref.read(favoriteRepository);
    final histRepo = ref.read(historyRepository);

    return GridTile(
        child: Container(
          decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 0.5)),
          child: GestureDetector(
          onTap: () {
            histRepo.addHistory(widget.word);
            showModalBottomSheet<void>(
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return DetailWord(word: widget.word, listWords: widget.words);
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
                      Text(widget.word),
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: (){
                          if(!isFavorite) {
                            favorite.addFavorite(widget.word);
                          }else{
                            favorite.removeFavorite(widget.word);
                          }
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                        child: isFavorite ? const Icon(Icons.star) : const Icon(Icons.star_outline),
                      )
                    ]),
              )
          ),
        )
        ));
  }
}