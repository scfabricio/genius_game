import 'package:flutter/material.dart';
import 'package:genius_game/providers/genius_provider.dart';
import 'package:genius_game/widget/genius_suface.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> buttonData = [
      {"color": Colors.green, "opacity": 1.0},
      {"color": Colors.red, "opacity": 1.0},
      {"color": Colors.yellow, "opacity": 1.0},
      {"color": Colors.blue, "opacity": 1.0},
    ];

    Genius genius = Provider.of(context, listen: false);

    return Scaffold(
      body: FutureBuilder(
        future: genius.load(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Genius Game".toUpperCase(),
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      GeniusSuface(
                        buttonData: buttonData,
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed("/play");
                          },
                          child: Text("Play".toUpperCase()),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.symmetric(vertical: 10),
                            ),
                            textStyle: MaterialStateProperty.all<TextStyle>(
                              TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
