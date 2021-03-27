import 'package:flutter/material.dart';
import 'package:genius_game/widget/genius_button.dart';

class GeniusSuface extends StatelessWidget {
  List<Map<String, dynamic>> buttonData;
  Function handleClick;
  Function handleEndAnimated;
  bool isActive;

  GeniusSuface({
    @required this.buttonData,
    this.handleClick,
    this.handleEndAnimated,
    this.isActive = false,
  }); 

  List<Widget> getButtonsList() {
    List<Widget> children = [];

    for (var i = 0; i < buttonData.length; i = i + 2) {
      children.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GeniusButton(
              color: buttonData[i]["color"],
              opacity: buttonData[i]["opacity"],
              handleClick: isActive ? () => this.handleClick(i) : null,
              handleEndAnimated: () => this.handleEndAnimated(i),
            ),
            SizedBox(width: 10),
            GeniusButton(
              color: buttonData[i + 1]["color"],
              opacity: buttonData[i + 1]["opacity"],
              handleClick: isActive ? () => this.handleClick(i + 1) : null,
              handleEndAnimated: () => this.handleEndAnimated(i + 1),
            ),
          ],
        ),
      );
      if (i != 2) {
        children.add(SizedBox(height: 10));
      }
    }

    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: getButtonsList(),
    );
  }
}
