import 'package:flutter/material.dart';
import 'package:genius_game/utils/db_utils.dart';

class Genius with ChangeNotifier {
  int _maxScore = 0;

  Genius();

  int get maxScore {
    return this._maxScore;
  }

  set maxScore(value) {
    this._maxScore = value;
  }

  Future<void> load() async {
    final data = await DBUtils.getData("genius");
    this._maxScore = data[0]["maxscore"] ?? 0;
    notifyListeners();
  }

  Future<void> saveMaxScore(int value) async {
    if (this._maxScore == 0) {
      await DBUtils.insert("genius", {"maxscore": value});
    } else {
      await DBUtils.update("genius", {"maxscore": value});
    } 
    this._maxScore = value;
    notifyListeners();
  }
}
