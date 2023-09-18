import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TopBar extends ConsumerStatefulWidget {
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => TopBarState();
}

class TopBarState extends ConsumerState<TopBar> {
  @override
  Widget build(BuildContext context) {

    return AppBar(
        title: const Text(
          'Coodesh', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false);
  }
}
