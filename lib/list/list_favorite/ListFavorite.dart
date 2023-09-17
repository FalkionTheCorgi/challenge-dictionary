import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truckpag_challenge/list/list_favorite/ListFavoriteItem.dart';
import '../../database/FavoriteRepository.dart';

class ListFavorite extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ListFavoriteState();
}

class ListFavoriteState extends ConsumerState<ListFavorite> {

  @override
  Widget build(BuildContext context) {

    final favRepo = ref.watch(favoriteRepository);

    // TODO: implement build
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: favRepo.favorite.isEmpty

        ? const Center(
          child: Text('No Favorite Registered'),
        )

        : GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this produces 2 rows.
          crossAxisCount: 3,
          // Generate 100 widgets that display their index in the List.
          children: [
            for(var element in favRepo.favorite) CardFavoriteItem(word: element.word)
          ]),
        );
  }

}