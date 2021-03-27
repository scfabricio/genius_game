import 'dart:math';

import 'package:flutter/material.dart';
import 'package:genius_game/providers/genius_provider.dart';
import 'package:genius_game/utils/time_utils.dart';
import 'package:genius_game/widget/genius_suface.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<int> randomPlay = [];
  int level = 1;
  bool isActive = false;
  int headPoint = 0;
  int points = 0;

  List<Map<String, dynamic>> buttonData = [
    {"color": Colors.green, "opacity": 1.0},
    {"color": Colors.red, "opacity": 1.0},
    {"color": Colors.yellow, "opacity": 1.0},
    {"color": Colors.blue, "opacity": 1.0},
  ];

  void generatePlay() {
    var rng = new Random();
    List<int> generateList = [];
    for (var i = 0; i < level * 2; i++) {
      generateList.add(rng.nextInt(buttonData.length));
    }
    setState(() {
      randomPlay = [...generateList];
    });
  }

  void setOpacity(int index, double opacity) {
    setState(() {
      buttonData[index]["opacity"] = opacity;
    });
  }

  void handleEndAnimated(int index) {
    setOpacity(index, 1.0);
  }

  void run() async {
    await awaitTime(Duration(seconds: 1));
    for (int i = 0; i < randomPlay.length; i++) {
      setOpacity(randomPlay[i], 0.0);
      await awaitTime(Duration(milliseconds: 700));
    }
    setState(() {
      isActive = true;
    });
  }

  void handleClick(int index, Genius genius) {
    setOpacity(index, 0.0);
    if (randomPlay[headPoint] == index) {
      setState(() {
        points = points + level;
        headPoint += 1;
      });

      if (points > genius.maxScore) {
        genius.saveMaxScore(points);
      }

      if (headPoint >= randomPlay.length) {
        setState(() {
          level += 1;
          isActive = false;
          headPoint = 0;
        });
        generatePlay();
        run();
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text("Vecê errou a sequencia! =("),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(1),
              child: Text("Jogar Novamente"),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(-1),
              child: Text("Fechar"),
            )
          ],
        ),
      ).then((value) {
        if (value == 1) {
          setState(() {
            level = 1;
            points = 0;
            isActive = false;
            headPoint = 0;
          });
          generatePlay();
          run();
        } else {
          Navigator.of(context).pushNamed("/");
        }
      });
      setState(() {
        isActive = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    generatePlay();
    run();
  }

  @override
  Widget build(BuildContext context) {
    Genius _genius = Provider.of(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Game"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isActive ? "PLAY" : "Aguarde...",
            style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 210,
            child: GeniusSuface(
              buttonData: buttonData,
              handleClick: (int index) => handleClick(index, _genius),
              handleEndAnimated: handleEndAnimated,
              isActive: isActive,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    points.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 100,
                    ),
                  ),
                  Text(
                    "SCORE",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(width: 40),
              Column(
                children: [
                  Text(
                    _genius.maxScore.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 100,
                    ),
                  ),
                  Text(
                    "MAX SCORE",
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
