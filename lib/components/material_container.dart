import 'package:flutter/material.dart';

class MaterialContainer extends StatelessWidget {
  final Widget child;
  final double borderRadius = 10;

  const MaterialContainer({
    Key key,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          borderRadius,
        ),
      ),
      child: child,
    );
  }
}
