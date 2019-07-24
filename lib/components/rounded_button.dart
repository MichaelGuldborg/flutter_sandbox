import 'package:flutter/material.dart';
import 'package:sandbox/app_colors.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool inverted;

  const RoundedButton({
    Key key,
    @required this.text,
    @required this.onPressed,
    this.inverted = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = inverted ? AppColors.secondary : AppColors.white;
    final textColor = inverted ? AppColors.white : AppColors.secondary;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        MaterialButton(
          shape: StadiumBorder(),
          color: backgroundColor,
          padding: EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 40,
          ),
          elevation: 10,
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
