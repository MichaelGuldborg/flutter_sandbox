import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final int max;
  final int index;
  final double radius;
  final Color background;
  final Color color;

  const ProgressBar({
    Key key,
    @required this.max,
    @required this.index,
    this.radius = 10,
    this.background = Colors.black12,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: 32,
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        final double questionWidth = constraints.maxWidth / max;
        return Stack(
          children: <Widget>[
            Container(
              height: 10,
              decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
            AnimatedContainer(
              height: 10,
              width: questionWidth * index,
              duration: const Duration(milliseconds: 250),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
          ],
        );
      }),
    );
  }
}
