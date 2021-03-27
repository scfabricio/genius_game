import 'package:flutter/material.dart';

class GeniusButton extends StatelessWidget {
  final Function handleClick;
  final Function handleEndAnimated;
  final double opacity;
  final Color color;

  GeniusButton({
    this.handleClick,
    this.handleEndAnimated,
    this.opacity,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: handleClick,
      child: AnimatedOpacity(
        opacity: opacity,
        onEnd: handleEndAnimated,
        duration: Duration(milliseconds: 300),
        child: Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: color,
          ),
        ),
      ),
    );
  }
}
