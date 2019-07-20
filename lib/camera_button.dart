import 'package:flutter/material.dart';

class CameraButton extends StatefulWidget {
  final VoidCallback onPressed;

  const CameraButton({Key key, this.onPressed}) : super(key: key);

  @override
  _CameraButtonState createState() => _CameraButtonState();
}

class _CameraButtonState extends State<CameraButton> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  double _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      lowerBound: 0.0,
      upperBound: 0.2,
    )..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 + _controller.value;
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        _controller.forward();
      },
      onTapUp: (TapUpDetails details) {
        _controller.reverse();
      },
      onTap: widget.onPressed,
      child: Transform.scale(
        scale: _scale,
        child: Container(
          width: 80,
          height: 80,
          margin: EdgeInsets.symmetric(vertical: 32),
          decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 4)),
        ),
      ),
    );
  }
}
