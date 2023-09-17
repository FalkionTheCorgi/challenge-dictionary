import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truckpag_challenge/bottombar/BottomBar.dart';
import 'package:truckpag_challenge/bottombar/BottomBarViewModel.dart';
import 'package:truckpag_challenge/list/list_favorite/ListFavorite.dart';
import 'package:truckpag_challenge/list/list_history/ListHistory.dart';
import 'package:truckpag_challenge/list/list_words/ListWords.dart';

import '../topbar/TopBar.dart';

class TabBarController extends ConsumerStatefulWidget {
  const TabBarController({Key? key}) : super(key: key);

  @override
  ConsumerState<TabBarController> createState() => TabBarControllerState();
}

class TabBarControllerState extends ConsumerState<TabBarController> {
  final key = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final bottomBarModel = ref.watch(bottomBarViewModel);

    return DefaultTabController(
        length: 3,
        child: Scaffold(
          key: key,
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: TopBar()),
          bottomNavigationBar: const BottomBar(),
          body: TabBarView(
            children: [
              if (bottomBarModel.selectedIndex == 0) ListWords(),
              if (bottomBarModel.selectedIndex == 1) ListHistory(),
              if (bottomBarModel.selectedIndex == 2) ListFavorite()
            ],
          ),
        ));
  }
}
