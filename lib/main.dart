import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:truckpag_challenge/extension/ColorTheme.dart';
import 'package:truckpag_challenge/routes/AppRoutes.dart';

Future main() async {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final darkmode = false;

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coodesh',
      initialRoute: AppRoutes.start,
      onGenerateRoute: AppRoutes.generateRoute,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            primary: ColorTheme.colorFirst,
            onPrimary: Colors.black,
            secondary: Colors.black,
            onSurface: Colors.black,
            background: Colors.white),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
            brightness: Brightness.dark,
            primary: ColorTheme.colorFirst,
            onPrimary: Colors.white,
            secondary: Colors.green,
            onSecondary: Colors.white,
            primaryContainer: Colors.pink,
            onSecondaryContainer: ColorTheme.colorGrey,
            onError: Colors.white,
            background: Colors.black,
            onBackground: Colors.white,
            surface: ColorTheme.colorGrey,
            onSurface: Colors.white,
            onSurfaceVariant: Colors.white),
        useMaterial3: true,
      ),
      themeMode: darkmode ? ThemeMode.dark : ThemeMode.light,
    );
  }
}
