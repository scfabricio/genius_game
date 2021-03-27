import 'package:flutter/material.dart';
import 'package:genius_game/providers/genius_provider.dart';
import 'package:genius_game/screens/game_screen.dart';
import 'package:genius_game/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Genius()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          "/": (ctx) => HomeScreen(),
          "/play": (ctx) => GameScreen(),
        },
      ),
    );
  }
}
