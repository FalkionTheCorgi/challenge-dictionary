import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truckpag_challenge/database/HistoryRepository.dart';
import 'package:truckpag_challenge/database/MeaningRepository.dart';
import 'package:truckpag_challenge/database/WordDescriptionRepository.dart';
import 'package:truckpag_challenge/extension/Functions.dart';
import 'package:truckpag_challenge/list/list_words/ListWordsViewModel.dart';
import 'package:truckpag_challenge/list/detail_word/DetailWordViewModel.dart';
import 'package:uuid/uuid.dart';

import '../../../api/data/Word.dart';

class DetailWord extends ConsumerStatefulWidget {
  String word;
  List<String> listWords;

  DetailWord({super.key, required this.word, required this.listWords});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => DetailWordState();
}

class DetailWordState extends ConsumerState<DetailWord> {
  @override
  void initState() {
    final model = ref.read(detailWordViewModel);
    final meaningRepo = ref.read(meaningRepository);
    final wordDescRepo = ref.read(wordDescriptionRepository);

    if (!wordDescRepo.existWord(widget.word)) {
      model.getWordDescription(widget.word).then(
              (value) {
          if(value is Word){
            String uuid = const Uuid().v4();
            wordDescRepo.addWordDescription(
                widget.word, value.pronunciation.all, uuid);
            for (var item in value.results) {
              meaningRepo.addMeaning(item.definition, uuid);
            }
          }
      });


    } else {

    final obj = wordDescRepo.wordDescription.firstWhere((element) => element.word == widget.word);
    final meanings = meaningRepo.meaning.where((element) => element.fkWordDescription == obj.idMeaning).toList();

    model.fillData(obj.pronunciation, meanings);


    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final model = ref.watch(detailWordViewModel);

    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: model.isLoadingContent
                ? SizedBox(
                    width: screenWidth,
                    height: 400,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ))
                : (model.pronunciation.isEmpty && model.meaning.isEmpty)
                    ? dataEmpty()
                    : showData()));
  }

  Widget dataEmpty() {
    final model = ref.watch(detailWordViewModel);
    final histRepo = ref.read(historyRepository);

    return Column(mainAxisSize: MainAxisSize.min, children: [
      Center(
        child: Text(
          '${widget.word} was not recognized',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
        ),
      ),
      const SizedBox(
        height: 16,
      ),
      Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: OutlinedButton(
              onPressed: () {
                final pos = widget.listWords.indexOf(widget.word);
                if (pos == 0) {
                  //disable button
                } else {
                  setState(() {
                    widget.word = widget.listWords[pos - 1];
                    histRepo.addHistory(widget.word);
                    model.getWordDescription(widget.word);
                  });
                }
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child:
                  const Text('Voltar', style: TextStyle(color: Colors.black)),
            )),
            const SizedBox(width: 8),
            Expanded(
                child: OutlinedButton(
              onPressed: () {
                final pos = widget.listWords.indexOf(widget.word);
                if (pos == widget.listWords.length - 1) {
                  //disable button
                } else {
                  setState(() {
                    widget.word = widget.listWords[pos + 1];
                    histRepo.addHistory(widget.word);
                    model.getWordDescription(widget.word);
                  });
                }
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text(
                'Próximo',
                style: TextStyle(color: Colors.black),
              ),
            )),
          ])
    ]);
  }

  Widget showData() {
    double screenWidth = MediaQuery.of(context).size.width;
    final model = ref.watch(detailWordViewModel);
    final histRepo = ref.read(historyRepository);

    return Column(mainAxisSize: MainAxisSize.min, children: [
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.close),
          )
        ],
      ),
      const SizedBox(height: 16),
      Container(
          width: screenWidth,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
            ),
            color: Colors.pinkAccent,
          ),
          child: Column(
            children: [
              const Spacer(),
              Center(
                child: Text(
                  "${widget.word}",
                  style: const TextStyle(fontSize: 18.0),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              if (model.pronunciation.isNotEmpty)
                Center(
                  child: Text(
                    model.pronunciation,
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ),
              const Spacer(),
            ],
          )),
      const SizedBox(height: 16),
      Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.play_arrow_outlined),
            ),
            /*const SizedBox(height: 8),
                  const LinearProgressIndicator(
                    value: 50.0,
                    backgroundColor: Colors.lightBlueAccent,
                    color: Colors.red,
                    minHeight: 15,
                  )*/
          ]),
      const SizedBox(height: 16),
      if (model.meaning.isNotEmpty)
        const Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Meanings',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
              ),
            ]),
      SizedBox(
        width: double.infinity,
        child: Wrap(
          alignment: WrapAlignment.start,
          children: [
            for (var mean in model.meaning) Text(mean.capitalize()),
          ],
        ),
      ),
      const SizedBox(height: 16),
      Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: OutlinedButton(
              onPressed: () {
                final pos = widget.listWords.indexOf(widget.word);
                if (pos == 0) {
                  //disable button
                } else {
                  setState(() {
                    widget.word = widget.listWords[pos - 1];
                    histRepo.addHistory(widget.word);
                    model.getWordDescription(widget.word);
                  });
                }
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child:
                  const Text('Voltar', style: TextStyle(color: Colors.black)),
            )),
            const SizedBox(width: 8),
            Expanded(
                child: OutlinedButton(
              onPressed: () {
                final pos = widget.listWords.indexOf(widget.word);
                if (pos == widget.listWords.length - 1) {
                  //disable button
                } else {
                  setState(() {
                    widget.word = widget.listWords[pos + 1];
                    histRepo.addHistory(widget.word);
                    model.getWordDescription(widget.word);
                  });
                }
              },
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const Text(
                'Próximo',
                style: TextStyle(color: Colors.black),
              ),
            )),
          ])
    ]);
  }
}
