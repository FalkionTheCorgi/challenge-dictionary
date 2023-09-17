import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truckpag_challenge/list/list_words/ListWordsItem.dart';
import 'package:truckpag_challenge/list/list_words/ListWordsViewModel.dart';

class ListWords extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => ListWordsState();
}

class ListWordsState extends ConsumerState<ListWords> {

  late final ScrollController _scrollController;
  bool showProgress = false;

  @override
  void initState() {
    final model = ref.read(listWordsViewModel);
    model.getWords();
    _scrollController = ScrollController();
    _scrollController.addListener(infiniteScrolling);
    super.initState();
  }

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

  infiniteScrolling() async {
    final model = ref.read(listWordsViewModel);
    if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
      setState(() {
        showProgress = true;
      });
      await model.getWordsByPage();
      setState(() {
        showProgress = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.watch(listWordsViewModel);

    // TODO: implement build
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: model.wordShowed.isEmpty
            ? ProgressView()
            : Stack(
                children: [
                  GridView.count(
                    controller: _scrollController,
                    crossAxisCount: 3,
                    children: [
                      for (var str in model.wordShowed)
                        Center(
                          child: CardWordItem(
                            word: str,
                            words: model.wordShowed,
                          ),
                        ),
                    ],
                  ),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      // start at end/bottom of column
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        if ((model.wordShowed.length < model.words.length) && showProgress)
                          Center(
                              //  center in horizontal axis
                              child: ProgressView())
                      ])
                ],
              ));
  }

  Widget ProgressView() {
    return const Center(child: CircularProgressIndicator());
  }
}
