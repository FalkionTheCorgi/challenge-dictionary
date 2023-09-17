import 'package:flutter/material.dart';
import 'package:truckpag_challenge/list/list_words/detail_word/DetailWord.dart';
import 'package:truckpag_challenge/tabbar/TabBarController.dart';

class AppRoutes {
  static const String start = '/';
  static const String detail = '/detail';

  static Route<dynamic> generateRoute(RouteSettings settings,
      {Object? arguments}) {
    switch (settings.name) {
      case start:
        return MaterialPageRoute(builder: (_) => const TabBarController());
      /*case detail:
        final args = settings.arguments as String;
        return AppRoutes().buildPageRouteBuilder(DetailWord(word: args));*/
      default:
        return MaterialPageRoute(builder: (_) => const TabBarController());
    }
  }

  PageRouteBuilder<dynamic> buildPageRouteBuilder(Widget view) {
    return PageRouteBuilder<dynamic>(
      pageBuilder: (context, animation, secondaryAnimation) => view,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
      transitionDuration: const Duration(milliseconds: 1000),
    );
  }
}
